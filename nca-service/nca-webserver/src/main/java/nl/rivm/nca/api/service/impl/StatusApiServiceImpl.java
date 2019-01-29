package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.StatusApiService;
import nl.rivm.nca.api.service.util.WarningUtil;

public class StatusApiServiceImpl extends StatusApiService {
    @Override
    public Response getStatusJobs(String apiKey, SecurityContext securityContext) throws NotFoundException {
        return Response.ok().entity(getStatus(apiKey)).build();
    }

	private ValidateResponse getStatus(String apiKey) {
		final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
		result.setWarnings(WarningUtil.WarningValidationMessageNoImplementation());
		return result;
	}
}