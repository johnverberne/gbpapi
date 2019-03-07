package nl.rivm.nca.api.service.util;

import javax.ws.rs.core.Response;

import nl.rivm.nca.api.domain.ApiServiceContext;

public class SwaggerUtil {

  public static Response handleException(ApiServiceContext context, Exception e) {
    return Response.serverError().build(); // redo 
  }

}
