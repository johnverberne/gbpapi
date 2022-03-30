package nl.rivm.nca.api.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.AssessmentRequestResponse;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.AssessmentResultsResponse;
import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.AssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.db.PMF;
import nl.rivm.nca.db.measures.MeasuresRepository;
import nl.rivm.nca.pcraster.EnvironmentEnum;
import nl.rivm.nca.pcraster.Measures;
import nl.rivm.nca.pcraster.NkModelController;
import nl.rivm.nca.pcraster.RunnerEnum;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

public class AssessmentRequestApiServiceImpl extends AssessmentRequestApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(AssessmentRequestApiServiceImpl.class);

  private final ApiServiceContext context;
  final static ObjectMapper mapper = new ObjectMapper();

  public AssessmentRequestApiServiceImpl() {
    this(new ApiServiceContext());
  }

  AssessmentRequestApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response postAssessmentRequest(final String apiKey, final FeatureCollection geoJson, final String jobKey, final String measureKey,
      final SecurityContext securityContext) throws NotFoundException {
    AssessmentRequestResponse response;
    try {
      response = calculate(apiKey, jobKey, measureKey, geoJson);
    } catch (AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
    return Response.ok().entity(response).build();
  }

  private AssessmentRequestResponse calculate(final String apiKey, String jobKey, final String measureKey, final FeatureCollection features)
      throws AeriusException {
    AssessmentRequestResponse response = new AssessmentRequestResponse();
    List<ValidationMessage> warnings = new ArrayList<>();
    List<ValidationMessage> errors = new ArrayList<>();
    response.setAssessmentResults(new ArrayList<AssessmentResultsResponse>());
    response.setWarnings(warnings);
    response.setErrors(errors);

    Boolean jobRerun = true;
    final Path path = Paths.get("/tmp/" + jobKey);
    if (jobKey == null || jobKey.isEmpty() || !Files.exists(path)) {
      jobKey = UUID.randomUUID().toString();
      jobRerun = false;
    }
    response.setJobKey(jobKey);
    MeasureCollection measuresCollection = null;

    try {
      final ScenarioUser user;

      final PMF pmf = context.getPMF();
      try (final Connection con = pmf.getConnection()) {
        user = UserUtil.getUser(con, apiKey);
        if (measureKey == null || measureKey.isEmpty()) {
          measuresCollection = Measures.load();
        } else {
          String modelMeasure = MeasuresRepository.getMeasuresByUser(con, user.getId(), measureKey);
          if (modelMeasure == null || modelMeasure.isEmpty()) {
            throw new AeriusException(Reason.CALCULATION_NO_MEASURE, measureKey);
          }
          measuresCollection = getMeasureCollection(modelMeasure);
        }
      }

      response.getAssessmentResults().add(scenarioCalculation(features, warnings, errors, jobKey, measuresCollection, jobRerun));
      response.setSuccessful(true);
    } catch (AeriusException a) {
      LOGGER.error("Calculation Exception :", a);
      throw new AeriusException(a.getReason(), a.getArgs());
    } catch (Exception e) {
      LOGGER.error("Calculation failed:", e);
      throw new AeriusException(Reason.INTERNAL_ERROR);
    }
    return response;
  }

  private AssessmentResultsResponse scenarioCalculation(FeatureCollection features,
      List<ValidationMessage> warnings, List<ValidationMessage> errors, String uuid, final MeasureCollection measureCollection,
      final Boolean jobRerun) throws AeriusException {
    AssessmentResultsResponse response = new AssessmentResultsResponse();
    response.setKey(uuid);
    try {
      final NkModelController controller = initController();
      LOGGER.info(features.toString());
      response.setEntries(singleCalculation(controller, features, warnings, errors, uuid, measureCollection, jobRerun));
    } catch (IOException | ConfigurationException | InterruptedException e) {
      LOGGER.error(e.getMessage());
      LOGGER.error(e.toString());
      throw new AeriusException(Reason.INTERNAL_ERROR);
    } catch (AeriusException e) {
      throw AeriusExceptionConversionUtil.convert(e, context.getLocale());
    }
    return response;
  }

  private List<AssessmentResultResponse> singleCalculation(final NkModelController controller, final FeatureCollection features,
      final List<ValidationMessage> warnings, final List<ValidationMessage> errors, final String uuid, final MeasureCollection measureCollection,
      final Boolean jobRerun)
      throws IOException, ConfigurationException, InterruptedException, AeriusException {
    List<AssessmentResultResponse> response = new ArrayList<>();
    response.addAll(assessmentRun(controller, features, uuid, measureCollection, jobRerun, warnings));
    return response;
  }

  private List<AssessmentResultResponse> assessmentRun(final NkModelController controller, final FeatureCollection features, final String uuid,
      final MeasureCollection measureCollection, final Boolean jobRerun, final List<ValidationMessage> warnings)
      throws IOException, ConfigurationException, InterruptedException, AeriusException {
    List<AssessmentResultResponse> results = new ArrayList<>();
    results.addAll(controller.run(uuid, measureCollection, jobRerun, features, warnings));
    return results;
  }

  private NkModelController initController() throws IOException, InterruptedException, AeriusException {
    // path to source files for the maps
    final String ncaModelRaster = EnvironmentEnum.NCA_MODEL_RASTER.getEnv();
    // path to runner files to run pc raster commands.
    final String ncaModelRunner = EnvironmentEnum.NCA_MODEL_RUNNER.getEnv();

    if (ncaModelRaster == null || ncaModelRunner == null) {
      LOGGER.error("Environment variable 'NCA_MODEL_RASTER or NCA_MODEL_RUNNER' not set. This should point to the raster data and Scripts.");
      throw new AeriusException(Reason.INTERNAL_ERROR);
    }
    // test if all runner files exist
    for (RunnerEnum runner : RunnerEnum.values()) {
      String script = runner.getRunner();
      File tmpDir = new File(script);
      if (!tmpDir.exists()) {
        LOGGER.error("Problem with runner file does not exist {}", script);
      }

    }

    return new NkModelController(new File(ncaModelRaster));
  }

  private MeasureCollection getMeasureCollection(final String body) throws IOException {
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    return mapper.readValue(body, MeasureCollection.class);
  }

}
