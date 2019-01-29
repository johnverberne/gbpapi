package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.service.AssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.WarningUtil;

public class AssessmentRequestApiServiceImpl extends AssessmentRequestApiService {

	@Override
	public Response postAssessmentRequest(AssessmentRequest body, SecurityContext securityContext)
			throws NotFoundException {
		return Response.ok().entity(postRequest(body)).build();
	}

	private ValidateResponse postRequest(AssessmentRequest body) {
		final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
		result.setWarnings(WarningUtil.WarningValidationMessageNoImplementation());
		return result;
	}

}