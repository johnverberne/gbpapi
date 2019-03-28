package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentScenarioRequest;
import nl.rivm.nca.api.service.AssessmentScenarioRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class AssessmentScenarioRequestApiServiceImpl extends AssessmentScenarioRequestApiService {

	@Override
	public Response postAssessmentScenarioRequest(String apiKey, AssessmentScenarioRequest body,
			SecurityContext securityContext) throws NotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

}
