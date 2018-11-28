package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.service.AssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class AssessmentRequestApiServiceImpl extends AssessmentRequestApiService {

    @Override
    public Response postAssessmentRequest(AssessmentRequest body, SecurityContext securityContext)
        throws NotFoundException {
      // TODO Auto-generated method stub
      return null;
    }
}
