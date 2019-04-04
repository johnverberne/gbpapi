package nl.rivm.nca.api.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentScenarioRequest;
import nl.rivm.nca.api.domain.ImmediatlyAssessmentRequestResponse;
import nl.rivm.nca.api.service.AssessmentScenarioRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class AssessmentScenarioRequestApiServiceImpl extends AssessmentScenarioRequestApiService {
	ImmediatlyAssessmentRequestApiServiceImpl immediatlyAssessmentRequestApiServiceImpl;

	@Override
	public Response postAssessmentScenarioRequest(String apiKey, List<AssessmentScenarioRequest> scenarios,
			SecurityContext securityContext) throws NotFoundException {
		immediatlyAssessmentRequestApiServiceImpl = new ImmediatlyAssessmentRequestApiServiceImpl();
		List<ImmediatlyAssessmentRequestResponse> response = calculate(apiKey, scenarios);
		return Response.ok().entity(response).build();
	}

	private List<ImmediatlyAssessmentRequestResponse> calculate(String apiKey,
			List<AssessmentScenarioRequest> scenarios) {
		List<ImmediatlyAssessmentRequestResponse> responses = new ArrayList<>();
		scenarios.forEach(scenario -> scenario.getMeasures().forEach(
				measure -> responses.add(immediatlyAssessmentRequestApiServiceImpl.calculate(apiKey, measure))));
		return responses;
	}

}
