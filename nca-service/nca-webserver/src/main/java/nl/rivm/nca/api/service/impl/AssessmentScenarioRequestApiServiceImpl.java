package nl.rivm.nca.api.service.impl;

import java.util.List;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentScenarioRequest;
import nl.rivm.nca.api.domain.ImmediatlyAssessmentRequestResponse;
import nl.rivm.nca.api.service.AssessmentScenarioRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class AssessmentScenarioRequestApiServiceImpl extends AssessmentScenarioRequestApiService {
	ImmediatlyAssessmentRequestApiServiceImpl immediatlyAssessmentRequestApiServiceImpl = new ImmediatlyAssessmentRequestApiServiceImpl();
	
	@Override
	public Response postAssessmentScenarioRequest(String apiKey, List<AssessmentScenarioRequest> scenarios,
			SecurityContext securityContext) throws NotFoundException {
	    ImmediatlyAssessmentRequestResponse response = calculate(apiKey, scenarios);
	    return Response.ok().entity(response).build();
	}

	private ImmediatlyAssessmentRequestResponse calculate(String apiKey, List<AssessmentScenarioRequest> scenarios) {
		return immediatlyAssessmentRequestApiServiceImpl.calculate(apiKey, scenarios.get(0).getMeasures().get(0));
	}

}
