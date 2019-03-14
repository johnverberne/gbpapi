package nl.rivm.nca.api.service.util;

import javax.ws.rs.core.Response;

import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.exception.AeriusException;

public class SwaggerUtil {

  public static Response handleException(ApiServiceContext context, AeriusException e) {
    return Response.serverError().build(); // redo 
  }


}
