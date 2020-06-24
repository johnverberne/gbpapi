package nl.rivm.nca.api.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.AssessmentResultsResponse;
import nl.rivm.nca.api.domain.AssessmentTKSRequestResponse;
import nl.rivm.nca.api.domain.AssessmentTKSResultResponse;
import nl.rivm.nca.api.domain.AssessmentTKSResultsResponse;
import nl.rivm.nca.api.domain.FeatureCollection;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.AssessmentTKSRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.pcraster.EnvironmentEnum;
import nl.rivm.nca.pcraster.NkModelTKSController;

public class AssessmentTKSRequestApiServiceImpl extends AssessmentTKSRequestApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(AssessmentTKSRequestApiServiceImpl.class);

  @Override
  public Response postAssessmentTKSRequest(String apiKey, FeatureCollection geoJson, SecurityContext securityContext) throws NotFoundException {
    AssessmentTKSRequestResponse response = calculate(apiKey, geoJson);
    return Response.ok().entity(response).build();
  }

  @SuppressWarnings("unchecked")
  private AssessmentTKSRequestResponse calculate(String apiKey, FeatureCollection features) {
    AssessmentTKSRequestResponse response = new AssessmentTKSRequestResponse();
    List<ValidationMessage> warnings = new ArrayList<>();
    List<ValidationMessage> errors = new ArrayList<>();
    response.setAssessmentResults(new ArrayList<AssessmentTKSResultsResponse>());
    response.setWarnings(warnings);
    response.setErrors(errors);
    final String uuid = UUID.randomUUID().toString();
    // keep uuid for task
    response.setKey(uuid);

    try {
      response.getAssessmentResults().add(scenarioCalculation(features, warnings, errors, uuid));
    } catch (RuntimeException e) {
//      ValidationMessage message = new ValidationMessage();
//      message.setCode(1);
//      message.setMessage("error is call : " + e.getMessage());
      errors.add(WarningUtil.ValidationInfoMessage(
          "Task executed uuid: {} " + uuid + " encounterd a error "));
//      errors.add(message);
      response.setErrors(errors);
      response.setSuccessful(false);
      throw e;
    }
    if (response.isSuccessful() == null) {
      response.setSuccessful(true);
    }
    return response;
  }

  private AssessmentTKSResultsResponse scenarioCalculation(FeatureCollection features,
      List<ValidationMessage> warnings, List<ValidationMessage> errors, String uuid) {
    AssessmentTKSResultsResponse response = new AssessmentTKSResultsResponse();
    response.setKey(uuid);
    try {
      final NkModelTKSController controller = initController(true);
      response.setEntries(singleCalculation(controller, features, warnings, errors, uuid));
      //response.setUrl(controller.getDownloadFileUrl());
    } catch (IOException | ConfigurationException e) {
      throw new RuntimeException(e);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      throw new RuntimeException(e);
    }
    return response;
  }

  private List<AssessmentTKSResultResponse> singleCalculation(NkModelTKSController controller, FeatureCollection features,
      List<ValidationMessage> warnings,
      List<ValidationMessage> errors, final String uuid)
      throws IOException, ConfigurationException, InterruptedException {
    List<AssessmentTKSResultResponse> response = new ArrayList<>();
    response.addAll(assessmentRun(controller, features, uuid));
    return response;
  }

  private List<AssessmentTKSResultResponse> assessmentRun(NkModelTKSController controller, FeatureCollection features, final String uuid)
      throws IOException, ConfigurationException, InterruptedException {
    List<AssessmentTKSResultResponse> results = new ArrayList<>();
    results.addAll(controller.run(uuid, features));
    return results;
  }

  private NkModelTKSController initController(boolean directFile) throws IOException, InterruptedException {
    final String ncaModel = EnvironmentEnum.NCA_MODEL_RASTER.getEnv();
    final String ncaModelRunner = EnvironmentEnum.NCA_MODEL_RUNNER.getEnv();

    if (ncaModel == null || ncaModelRunner == null) {
      throw new IllegalArgumentException(
          "Environment variable 'NCA_MODEL_RASTER or NCA_MODEL_RUNNER' not set. This should point to the raster data and Scripts.");
    }
    return new NkModelTKSController(new File(ncaModel), directFile);
  }
}
