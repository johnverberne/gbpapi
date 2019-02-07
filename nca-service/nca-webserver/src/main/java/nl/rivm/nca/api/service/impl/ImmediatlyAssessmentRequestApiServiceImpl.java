package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.ImmediatlyAssessmentRequestResponse;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.service.ImmediatlyAssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.WarningUtil;

public class ImmediatlyAssessmentRequestApiServiceImpl extends ImmediatlyAssessmentRequestApiService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ImmediatlyAssessmentRequestApiServiceImpl.class);
	
	@Override
	public Response postImmediatlyAssessmentRequest(AssessmentRequest assessmentRequest, SecurityContext securityContext)
			throws NotFoundException {
		ImmediatlyAssessmentRequestResponse response = calculate(assessmentRequest);
		return Response.ok().entity(response).build();
	}

	private ImmediatlyAssessmentRequestResponse calculate(AssessmentRequest ar) {
		final ImmediatlyAssessmentRequestResponse response = new ImmediatlyAssessmentRequestResponse();

		response.successful(Boolean.FALSE);
		response.setWarnings(WarningUtil.WarningValidationMessageNoImplementation());
		response.setKey("xxxx");
		response.assessmentResults(null);

		return response;
	}
	
}
