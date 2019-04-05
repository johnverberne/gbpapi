package nl.rivm.nca.api.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.AssessmentResultsResponse;
import nl.rivm.nca.api.domain.AssessmentScenarioRequest;
import nl.rivm.nca.api.domain.AssessmentScenarioRequestResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.domain.AssessmentRequest.ModelEnum;
import nl.rivm.nca.api.service.AssessmentScenarioRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.pcraster.ImmediatlyController;
import nl.rivm.nca.pcraster.SingleRun;

public class AssessmentScenarioRequestApiServiceImpl extends AssessmentScenarioRequestApiService {

	@Override
	public Response postAssessmentScenarioRequest(String apiKey, List<AssessmentScenarioRequest> scenarios,
			SecurityContext securityContext) throws NotFoundException {
		AssessmentScenarioRequestResponse response = calculate(apiKey, scenarios);
		return Response.ok().entity(response).build();
	}

	private AssessmentScenarioRequestResponse calculate(String apiKey, List<AssessmentScenarioRequest> scenarios) {
		AssessmentScenarioRequestResponse response = new AssessmentScenarioRequestResponse();
		List<ValidationMessage> warnings = new ArrayList<>();
		List<ValidationMessage> errors = new ArrayList<>();
		response.setAssessmentResults(new ArrayList<>());
		response.setWarnings(warnings);
		response.setErrors(errors);
		final String uuid = UUID.randomUUID().toString();
		scenarios.forEach(scenario -> {
			try {
				response.getAssessmentResults().add(scenarioCalculation(scenario, warnings, errors, uuid));
			} catch (RuntimeException e) {
				ValidationMessage message = new ValidationMessage();
				message.setCode(1);
				message.setMessage("error is call : " + e.getMessage());
				errors.add(WarningUtil.ValidationInfoMessage("Task executed uuid:" + uuid));
				response.setErrors(errors);
				response.setSuccessful(false);
			}
		});
		if (response.isSuccessful() == null) {
			response.setSuccessful(true);	
		}
		return response;
	}

	private AssessmentResultsResponse scenarioCalculation(AssessmentScenarioRequest scenario,
			List<ValidationMessage> warnings, List<ValidationMessage> errors, String uuid) {
		AssessmentResultsResponse response = new AssessmentResultsResponse();
		scenario.getMeasures().forEach(measure -> {
			try {
				response.setEntries(singleCalculation(measure, warnings, errors, uuid));
			} catch (IOException | ConfigurationException e) {
				throw new RuntimeException(e);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
				throw new RuntimeException(e);
			}
		});
		return response;
	}

	private List<AssessmentResultResponse> singleCalculation(AssessmentRequest ar, List<ValidationMessage> warnings,
			List<ValidationMessage> errors, final String uuid)
			throws IOException, ConfigurationException, InterruptedException {
		List<AssessmentResultResponse> response = new ArrayList<>();
		response.addAll(assessmentRun(ar, uuid));
		return response;
	}

	private List<AssessmentResultResponse> assessmentRun(AssessmentRequest ar, final String uuid)
			throws IOException, ConfigurationException, InterruptedException {
		final ImmediatlyController controller = initController(true);
		final SingleRun singleRun = new SingleRun();

		List<AssessmentResultResponse> results = new ArrayList<>();
		ModelEnum runModel = ModelEnum.NKMODEL;
		results.addAll(controller.run(uuid, singleRun.singleRun(ar.getName(), "air_regulation",
				"/opt/nkmodel/nkmodel_scenario_trees/", SingleRun.XYZ_EXT, runModel)));
		return results;
	}

	private ImmediatlyController initController(boolean directFile) throws IOException, InterruptedException {
		final String ncaModel = System.getenv("NCA_MODEL");
		if (ncaModel == null) {
			throw new IllegalArgumentException(
					"Environment variable 'NCA_MODEL' not set. This should point to the raster data");
		}
		return new ImmediatlyController(new File(ncaModel), directFile);
	}

}
