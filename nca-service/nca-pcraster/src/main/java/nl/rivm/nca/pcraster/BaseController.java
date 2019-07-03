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

import javax.sql.rowset.Joinable;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.commons.io.FilenameUtils;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.factory.Hints;
import org.geotools.gce.geotiff.GeoTiffFormat;
import org.geotools.gce.geotiff.GeoTiffReader;
import org.geotools.geometry.Envelope2D;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.LayerObject;

public abstract class BaseController implements ControllerInterface {

  private static final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);

  public static final String GEOTIFF_EXT = "tiff";
  public static final String GEOTIFF_DOT_EXT = '.' + GEOTIFF_EXT;

  private static final String MAP_EXT = "map";
  protected static final String MAP_DOT_EXT = '.' + MAP_EXT;
  private static final String JSON_EXT = "json";
  private static final String WORKSPACE_NAME = "result";
  protected static final String OUTPUTS = "outputs";

  protected final RasterLayers rasterLayers;
  private final PcRasterRunner pcRasterRunner = new PcRasterRunner();
  private final PublishGeotiff publishGeotiff;
  private final boolean directFile;
  private final ObjectMapper mapper = new ObjectMapper();

  public BaseController(File path, boolean directFile) throws IOException, InterruptedException {
    rasterLayers = RasterLayers.loadRasterLayers(path);
    this.directFile = directFile;
    publishGeotiff = new PublishGeotiff(System.getenv(EnvironmentConstants.GEOSERVER_URL),
        System.getenv(EnvironmentConstants.GEOSERVER_USER), System.getenv(EnvironmentConstants.GEOSERVER_PASSWORD));
    // python via docker dan geen test draaien pcRasterRunner.sanityCheck();
  }

  // copy input geotiff files to working map and convert to pcraster format
  protected File copyInputToWorkingMap(Map<Layer, String> layerFiles, File workingPath, List<LayerObject> userLayers, String FILE_EXT,
      String prefix) {
    final List<File> files = userLayers.stream().map(ul -> writeToFile(layerFiles, workingPath, ul, FILE_EXT, prefix)).collect(Collectors.toList());
    files.forEach(this::convertOutput2GeoTiff);
    return files.isEmpty() ? null : files.get(0);
  }

  protected File writeToFile(Map<Layer, String> layerFiles, File workingPath, LayerObject layerObject, String FILE_EXT, String prefix) {
    final File targetFile = new File(workingPath, prefix + layerFiles.get(Layer.fromValue(layerObject.getClassType().toUpperCase())) + FILE_EXT);
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

  protected File directFile(byte[] data) {
    try {
      return directFile ? new File(URI.create(new String(data, StandardCharsets.UTF_8.displayName()))) : null;
    } catch (final IllegalArgumentException | UnsupportedEncodingException e) {
      return null;
    }
  }

  @Override
  public Envelope2D calculateExtend(File geoTiffFile) throws IOException {
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

  protected void cookieCutOtherLayersToWorkingPath(File workingPath, Map<Layer, String> layerFiles,
      List<LayerObject> userLayers, Envelope2D extend, java.util.logging.Logger jobLogger) throws IOException {
    final CookieCut cc = new CookieCut(workingPath.getAbsolutePath());
    final Set<String> userDefinedClasses = userLayers.stream().map(ul -> ul.getClassType())
        .collect(Collectors.toSet());
    // create all source files, including supplied
    layerFiles.entrySet().stream().filter(e -> !userDefinedClasses.contains(e.getKey())).forEach(e -> {
      try {
        final String sourceFile = e.getValue();

        cc.run(rasterLayers.mapOriginalFilePath(sourceFile), rasterLayers.mapFilePath(workingPath, sourceFile), extend, jobLogger);
      } catch (IOException | InterruptedException e1) {
        e1.printStackTrace();
      }
    });
  }

  protected void runPcRaster(String correlationId, String ecoSystemService, File projectFileScenario, File projectFileBaseLine, File workingPath)
      throws IOException, InterruptedException {
    pcRasterRunner.runPcRaster(correlationId, ecoSystemService, projectFileScenario, projectFileBaseLine, workingPath);
  }

  protected File convertOutput2GeoTiff(File geotiffFile) {
    // convert pcraster output files and return a list of geotiff images.
    final int indexOf = geotiffFile.getName().indexOf(GEOTIFF_EXT);
    if (indexOf < 0) {
      throw new RuntimeException("no geotiff file");
    }
    final File mapFile = new File(FilenameUtils.removeExtension(geotiffFile.getAbsolutePath()) + MAP_DOT_EXT);
    try {
      // convert input tiff to map
      LOGGER.info("Export geotiff2pcraster {} -> {}", geotiffFile, mapFile);
      Geotiff2PcRaster.geoTiff2PcRaster(geotiffFile, mapFile);
    } catch (final IOException e) {
      e.printStackTrace();
    }
    return mapFile;
  }

  protected void convertOutput(File outputPath, java.util.logging.Logger jobLogger) throws IOException {
    Files.list(outputPath.toPath()).filter(f -> MAP_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> {
          try {
            Geotiff2PcRaster.pcRaster2GeoTiff(f.toFile(), new File(
                FilenameUtils.removeExtension(f.toFile().getAbsolutePath()) + GEOTIFF_DOT_EXT), jobLogger);
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
  protected List<AssessmentResultResponse> importJsonResult(String correlationId, File outputPath)
      throws IOException {
    List<AssessmentResultResponse> returnList = new ArrayList<AssessmentResultResponse>();
    Files.list(outputPath.toPath()).filter(f -> JSON_EXT.equals(FilenameUtils.getExtension(f.toFile().getName())))
        .forEach(f -> {
          try {
            LOGGER.info("read result file {} {}", f.toFile().getAbsolutePath(), f.getFileName());
            @SuppressWarnings("resource")
            FileReader fr = new FileReader(f.toFile().getAbsolutePath());
            int i;
            String body = "";
            while ((i = fr.read()) != -1)
              body += (char) i;
            mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
            AssessmentResultResponse result = mapper.readValue(body, AssessmentResultResponse.class);
            result.setName(f.toFile().getName().replaceAll(".json", "").replaceAll("_", " ")); // also used to map to geotiff
            returnList.add(result);
            LOGGER.info("content of file for correlationId {} content {}", correlationId,
                result.toString());

          } catch (final Exception e) {
            // eat error
            LOGGER.warn("Reading and parsing of json failed {}", e.getMessage());
          }
        });
    return returnList;
  }

  protected boolean publishFiles(final String correlationId, File outputPath, java.util.logging.Logger jobLogger) throws IOException {
    boolean successfull = true;
    LOGGER.info("Scan {} for {}", outputPath.getPath(), GEOTIFF_EXT);
    jobLogger.info("Scan " + outputPath.getPath() + " for :" + GEOTIFF_EXT);
    Files.list(outputPath.toPath())
        .filter(f -> GEOTIFF_EXT.equals(FilenameUtils.getExtension(f.toFile().getName().toLowerCase())))
        .forEach(f -> LOGGER.info(f.toFile().getName().toLowerCase()));

    Files.list(outputPath.toPath())
        .filter(f -> GEOTIFF_EXT.equals(FilenameUtils.getExtension(f.toFile().getName().toLowerCase()))).forEach(f -> {
          try {
            publishGeotiff.publish(WORKSPACE_NAME, correlationId, f.toFile(),
                FilenameUtils.removeExtension(f.toFile().getName()), jobLogger);
          } catch (final IOException e) {
            // rewrite to throw an warning and eat error
            LOGGER.warn("Geoserver publication failed {}", e.getMessage());
            jobLogger.info("Geoserver publication failed :" + e.getMessage());
          }
        });
    return successfull;
  }

  protected void cleanUp(File dir, Boolean remove) throws IOException {
    if (remove) {
      deleteDirectoryRecursively(dir);
    }
  }

  private void deleteDirectoryRecursively(File dir) throws IOException {
    if (dir.isDirectory() == false) {
      System.out.println("Not a directory. Do nothing");
      return;
    }
    File[] listFiles = dir.listFiles();
    for (File file : listFiles) {
      if (file.isDirectory()) {
        deleteDirectoryRecursively(file);
      } else {
        boolean success = file.delete();
        LOGGER.info("Deleting {} Success = {}", file.getName(), success);
      }

    }
    // now directory is empty, so we can delete it
    LOGGER.info("Deleting Directory. Success = {}", dir.delete());
  }

}
