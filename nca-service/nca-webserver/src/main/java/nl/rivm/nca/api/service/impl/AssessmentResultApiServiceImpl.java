package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.service.AssessmentResultApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class AssessmentResultApiServiceImpl extends AssessmentResultApiService {

  @Override
  public Response getAssessmentResultById(String apiKey, String resultId, SecurityContext securityContext) 
      throws NotFoundException {
    return Response.ok(requestAssessmentResult(apiKey, resultId)).build();
  }

  private Object requestAssessmentResult(String apiKey, String resultId) {
    AssessmentResultResponse result = new AssessmentResultResponse();
    result.key("description for result");
    return result;
  }

}
