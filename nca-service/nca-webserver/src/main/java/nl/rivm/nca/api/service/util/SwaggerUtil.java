package nl.rivm.nca.api.service.util;

import java.util.Locale;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.Response.Status;

import nl.rivm.nca.api.domain.ErrorResponse;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.i18n.AeriusExceptionMessages;

public class SwaggerUtil {

  public static Response handleException(ApiServiceContext context, AeriusException e) {
    final ErrorResponse errorResponse = convert(context.getLocale(), e);
    final ResponseBuilder response = e.isInternalError() ? Response.serverError() : Response.status(Status.BAD_REQUEST);

    return response.entity(errorResponse).build();
  }

  private static ErrorResponse convert(Locale locale, AeriusException ae) {
    return new ErrorResponse().code(
        ae.getReason().getErrorCode()).message(new AeriusExceptionMessages(locale).getString(ae));
  }

}
