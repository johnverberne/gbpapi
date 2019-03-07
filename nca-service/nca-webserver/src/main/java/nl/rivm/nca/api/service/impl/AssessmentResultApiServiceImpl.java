package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentRequestResponse;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.service.AssessmentResultApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class AssessmentResultApiServiceImpl extends AssessmentResultApiService {

  @Override
  public Response getAssessmentResultById(String apiKey, String resultId, SecurityContext securityContext) 
      throws NotFoundException {
    return Response.ok(requestAssessmentResult(apiKey, resultId)).build();
  }

  private AssessmentRequestResponse requestAssessmentResult(String apiKey, String resultId) {
    AssessmentRequestResponse result = new AssessmentRequestResponse();
    result.key("you specified a request with apiKey (" + apiKey + ") and resultId (" + resultId + ")");
    return result;
  }
  
  // build a result set for the user
  
  

}
