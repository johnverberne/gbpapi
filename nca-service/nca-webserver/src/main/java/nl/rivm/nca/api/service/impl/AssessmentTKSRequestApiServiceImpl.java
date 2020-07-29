package nl.rivm.nca.api.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentTKSRequestResponse;
import nl.rivm.nca.api.domain.AssessmentTKSResultResponse;
import nl.rivm.nca.api.domain.AssessmentTKSResultsResponse;
import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.AssessmentTKSRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.WarningUtil;

import nl.rivm.nca.pcraster.EnvironmentEnum;
import nl.rivm.nca.pcraster.RunnerEnum;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;
import nl.rivm.nca.tks.pcraster.NkModelTKSController;

public class AssessmentTKSRequestApiServiceImpl extends AssessmentTKSRequestApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(AssessmentTKSRequestApiServiceImpl.class);

  private final ApiServiceContext context;

  public AssessmentTKSRequestApiServiceImpl() {
    this(new ApiServiceContext());
  }

  AssessmentTKSRequestApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response postAssessmentTKSRequest(String apiKey, FeatureCollection geoJson, SecurityContext securityContext) throws NotFoundException {
    try {
      AssessmentTKSRequestResponse response;
      response = calculate(apiKey, geoJson);
      return Response.ok().entity(response).build();
    } catch (AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
    
  }

  @SuppressWarnings("unchecked")
  private AssessmentTKSRequestResponse calculate(String apiKey, FeatureCollection features) throws AeriusException {
    AssessmentTKSRequestResponse response = new AssessmentTKSRequestResponse();
    List<ValidationMessage> warnings = new ArrayList<>();
    List<ValidationMessage> errors = new ArrayList<>();
    response.setAssessmentResults(new ArrayList<AssessmentTKSResultsResponse>());
    response.setWarnings(warnings);
    response.setErrors(errors);
    final String uuid = UUID.randomUUID().toString();
    response.setKey(uuid);

    try {
      response.getAssessmentResults().add(scenarioCalculation(features, warnings, errors, uuid));
    } catch (RuntimeException e) {
      throw new AeriusException(Reason.INTERNAL_ERROR);
    }
    if (response.isSuccessful() == null) {
      response.setSuccessful(true);
    }
    return response;
  }

  private AssessmentTKSResultsResponse scenarioCalculation(FeatureCollection features,
      List<ValidationMessage> warnings, List<ValidationMessage> errors, String uuid) throws AeriusException {
    AssessmentTKSResultsResponse response = new AssessmentTKSResultsResponse();
    response.setKey(uuid);
    try {
      final NkModelTKSController controller = initController();
      response.setEntries(singleCalculation(controller, features, warnings, errors, uuid));
    } catch (IOException | ConfigurationException | InterruptedException e) {
      throw new AeriusException(Reason.INTERNAL_ERROR);
    } catch (AeriusException e) {
      throw AeriusExceptionConversionUtil.convert(e, context.getLocale());
    }
    return response;
  }

  private List<AssessmentTKSResultResponse> singleCalculation(NkModelTKSController controller, FeatureCollection features,
      List<ValidationMessage> warnings,
      List<ValidationMessage> errors, final String uuid)
      throws IOException, ConfigurationException, InterruptedException, AeriusException {
    List<AssessmentTKSResultResponse> response = new ArrayList<>();
    response.addAll(assessmentRun(controller, features, uuid));
    return response;
  }

  private List<AssessmentTKSResultResponse> assessmentRun(NkModelTKSController controller, FeatureCollection features, final String uuid)
      throws IOException, ConfigurationException, InterruptedException, AeriusException {
    List<AssessmentTKSResultResponse> results = new ArrayList<>();
    results.addAll(controller.run(uuid, features));
    return results;
  }

  private NkModelTKSController initController() throws IOException, InterruptedException, AeriusException {
    // path to source files for the maps
    final String ncaModel = EnvironmentEnum.NCA_MODEL_RASTER.getEnv();
    // path to runner files to run pc raster commands.
    final String ncaModelRunner = EnvironmentEnum.NCA_MODEL_TKS_RUNNER.getEnv();

    if (ncaModel == null || ncaModelRunner == null) {
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

    return new NkModelTKSController(new File(ncaModel));
  }
}
