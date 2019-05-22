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
import nl.rivm.nca.api.service.AssessmentScenarioRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.pcraster.ControllerInterface;
import nl.rivm.nca.pcraster.NkModel2Controller;

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
		// keep uuid for task
		response.setKey(uuid);
		scenarios.forEach(scenario -> {
			// create unique uuid for each scenario
			final String scenario_uuid = UUID.randomUUID().toString();
			try {
				response.getAssessmentResults().add(scenarioCalculation(scenario, warnings, errors, scenario_uuid));
			} catch (RuntimeException e) {
				ValidationMessage message = new ValidationMessage();
				message.setCode(1);
				message.setMessage("error is call : " + e.getMessage());
				errors.add(WarningUtil.ValidationInfoMessage("Task executed uuid: " + uuid + " for scenario uuid: " + scenario_uuid ));
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
		response.setKey(uuid);
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
		final ControllerInterface controller = initController(true);
		List<AssessmentResultResponse> results = new ArrayList<>();
		results.addAll(controller.run(uuid, ar));
		return results;
	}

	private ControllerInterface initController(boolean directFile) throws IOException, InterruptedException {
		final String ncaModel = System.getenv("NCA_MODEL");
		if (ncaModel == null) {
			throw new IllegalArgumentException(
					"Environment variable 'NCA_MODEL' not set. This should point to the raster data");
		}
		return new NkModel2Controller(new File(ncaModel), directFile);
	}

}
