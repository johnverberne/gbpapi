package nl.rivm.nca.pcraster;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FilenameUtils;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.factory.Hints;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.gce.geotiff.GeoTiffReader;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.LayerObject;

public class Controller {

  private static final Logger LOGGER = LoggerFactory.getLogger(Controller.class);

  public static final String GEOTIFF_EXT = "tiff";
  public static final String GEOTIFF_DOT_EXT = '.' + GEOTIFF_EXT;
  private static final String MAP_EXT = "map";
  private static final String MAP_DOT_EXT = '.' + MAP_EXT;
  private static final String JSON_EXT = "json";
  private static final String WORKSPACE_NAME = "nca";
  private static final String OUTPUTS = "outputs";

  private final RasterLayers rasterLayers;
  private final PcRasterRunner pcRasterRunner = new PcRasterRunner();
  private final PublishGeotiff publishGeotiff;
  private final boolean directFile;
  private final ObjectMapper mapper = new ObjectMapper();

  public Controller(File path, boolean directFile) throws IOException, InterruptedException {
    rasterLayers = RasterLayers.loadRasterLayers(path);
    this.directFile = directFile;
    publishGeotiff = new PublishGeotiff(System.getenv("GEOSERVER_URL"), System.getenv("GEOSERVER_USER"),
        System.getenv("GEOSERVER_PASSWORD"));
    // python via docker dan geen test draaien pcRasterRunner.sanityCheck();
  }

  public List<AssessmentResultResponse> run(String correlationId, AssessmentRequest assessmentRequest)
      throws IOException, ConfigurationException, InterruptedException {
    final File workingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
    final File outputPath = Files.createDirectory(Paths.get(workingPath.getAbsolutePath(), OUTPUTS)).toFile();

    final Map<String, String> layerFiles = rasterLayers.getLayerFiles(assessmentRequest.getEcoSystemService());
    final File first = copyInputRastersToWorkingMap(layerFiles, workingPath, assessmentRequest.getLayers());
    final Envelope2D extend = calculateExtend(first);
    cookieCutOtherLayersToWorkingPath(workingPath, layerFiles, assessmentRequest.getLayers(), extend);
    final File projectFile = ProjectIniFile.generateIniFile(workingPath.getAbsolutePath(),
        outputPath.getAbsolutePath());
    runPcRaster(correlationId, assessmentRequest.getEcoSystemService(), projectFile);
    convertOutput(outputPath);
    List<AssessmentResultResponse> assessmentResultlist = importOutputToDatabase(correlationId, outputPath);
    publishFiles(correlationId, outputPath);
    cleanUp(workingPath);
    return assessmentResultlist;
  }

  // copy input geotiff files to working map and convert to pcraster format
  private File copyInputRastersToWorkingMap(Map<String, String> layerFiles, File workingPath,
      List<LayerObject> userLayers) {
    final List<File> files = userLayers.stream().map(ul -> writeToFile(layerFiles, workingPath, ul))
        .collect(Collectors.toList());
    files.forEach(this::convertOutput2GeoTiff);
    return files.isEmpty() ? null : files.get(0);
  }

  private File writeToFile(Map<String, String> layerFiles, File workingPath, LayerObject layerObject) {
    final File targetFile = userGeotiffFile(layerFiles, workingPath, layerObject);
    final File file = directFile(layerObject.getData());

    if (file == null || !file.exists()) {
      try (InputStream is = new ByteArrayInputStream(layerObject.getData())) {
        Files.copy(is, targetFile.toPath());
      } catch (final IOException e) {
        throw new RuntimeException(e);
      }
    } else {
      try {
        Files.copy(file.toPath(), targetFile.toPath());
      } catch (final IOException e) {
        e.printStackTrace();
      }
    }
    return targetFile;
  }

  private File directFile(byte[] data) {
    try {
      return directFile ? new File(URI.create(new String(data, StandardCharsets.UTF_8.displayName()))) : null;
    } catch (final IllegalArgumentException | UnsupportedEncodingException e) {
      return null;
    }
  }

  private File userGeotiffFile(Map<String, String> layerFiles, File workingPath, LayerObject layerObject) {
    return new File(workingPath, layerFiles.get(layerObject.getClassType()) + GEOTIFF_DOT_EXT);
  }

  private Envelope2D calculateExtend(File geoTiffFile) throws IOException {
    final GeoTiffFormat format = new GeoTiffFormat();
    final Hints hint = new Hints();
    // hint.put(Hints.FORCE_LONGITUDE_FIRST_AXIS_ORDER, Boolean.TRUE);
    final GeoTiffReader tiffReader = format.getReader(geoTiffFile, hint);
    final GridCoverage2D coverage = tiffReader.read(null);

    // final CoordinateReferenceSystem crs =
    // coverage.getCoordinateReferenceSystem();
    // check crs == RDNew?
    return coverage.getEnvelope2D();
  }

  private void cookieCutOtherLayersToWorkingPath(File workingPath, Map<String, String> layerFiles,
      List<LayerObject> userLayers, Envelope2D extend) throws IOException {
    final CookieCut cc = new CookieCut(workingPath.getAbsolutePath());
    final Set<String> userDefinedClasses = userLayers.stream().map(ul -> ul.getClassType()).collect(Collectors.toSet());
    layerFiles.entrySet().stream().filter(e -> !userDefinedClasses.contains(e.getKey())).forEach(e -> {
      try {
        final String sourceFile = e.getValue();

        cc.run(rasterLayers.mapOriginalFilePath(sourceFile), rasterLayers.mapFilePath(workingPath, sourceFile), extend);
      } catch (IOException | InterruptedException e1) {
        e1.printStackTrace();
      }
    });
  }

  private void runPcRaster(String correlationId, String ecoSystemService, File projectFile)
      throws IOException, InterruptedException {
    pcRasterRunner.runPcRaster(correlationId, ecoSystemService, projectFile);
  }

  private File convertOutput2GeoTiff(File geotiffFile) {
    // convert pcraster output files and return a list of geotiff images.
    final int indexOf = geotiffFile.getName().indexOf(GEOTIFF_EXT);

    if (indexOf < 0) {
      throw new RuntimeException("no geotiff file");
    }
    final File mapFile = new File(FilenameUtils.removeExtension(geotiffFile.getAbsolutePath()) + MAP_DOT_EXT);

    try {
      // convert input tiff to map
      LOGGER.info("geotiff2pcraster {} -> {}", geotiffFile, mapFile);
      Geotiff2PcRaster.geoTiff2PcRaster(geotiffFile, mapFile);
    } catch (final IOException e) {
      e.printStackTrace();
    }
    return mapFile;
  }

  private void convertOutput(File outputPath) throws IOException {
    Files.list(outputPath.toPath())
        .filter(f -> MAP_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> {
          try {
            Geotiff2PcRaster.pcRaster2GeoTiff(f.toFile(),
                new File(FilenameUtils.removeExtension(f.toFile().getAbsolutePath()) + GEOTIFF_DOT_EXT));
          } catch (final IOException e) {
            throw new RuntimeException(e);
          }
        });
  }
  
  /**
   * load generated json files and put in the database
   * 
   * @param outputPath
   * @throws IOException
   */
  private  List<AssessmentResultResponse> importOutputToDatabase(String correlationId, File outputPath) throws IOException {
	  List<AssessmentResultResponse> returnList = new ArrayList<AssessmentResultResponse>();
    Files.list(outputPath.toPath())
        .filter(f -> JSON_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> {
          try {
            LOGGER.info("read result file {}", f.getFileName());
            @SuppressWarnings("resource")
            FileReader fr = new FileReader(f.toFile().getAbsolutePath()); 
            int i; 
            String body ="";
            while ((i=fr.read()) != -1) 
              body += (char) i;
            
            AssessmentResultResponse result = mapper.readValue(body, AssessmentResultResponse.class);
			      returnList.add(result);
            LOGGER.info("content of file for correlationId {} content {}", correlationId,  result.toString());
            // lets write to database with id

          } catch (final Exception e) {
            LOGGER.warn("Reading and parsing of json failed {}", e);
            throw new RuntimeException(e);
          }
        });
    return returnList;
  }

  private boolean publishFiles(final String correlationId, File outputPath) throws IOException {
    boolean successfull = true;
    Files.list(outputPath.toPath())
        .filter(f -> GEOTIFF_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> LOGGER.info(f.toFile().getName()));

    Files.list(outputPath.toPath())
        .filter(f -> GEOTIFF_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> {
          try {
            publishGeotiff.publish(WORKSPACE_NAME, correlationId, f.toFile(),
                FilenameUtils.removeExtension(f.toFile().getName()));
          } catch (final IOException e) {
            // rewrite to throw an warning and eat error
            LOGGER.warn("Geoserver publication failed {}", e);
            //throw new RuntimeException(e);
          }
        });
    return successfull;
  }

  private void cleanUp(File workingPath) {
    // TODO Auto-generated method stub
  }
}
