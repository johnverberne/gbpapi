package nl.rivm.nca.api.service.impl;

import java.sql.Connection;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.ApiServiceContext;
import nl.rivm.nca.api.domain.GenerateAPIKeyRequest;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.GenerateAPIKeyApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.api.service.util.WarningUtil;

public class GenerateAPIKeyApiServiceImpl extends GenerateAPIKeyApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(ImmediatlyAssessmentRequestApiServiceImpl.class);

  private final ApiServiceContext context;

  GenerateAPIKeyApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response postGenerateAPIKey(GenerateAPIKeyRequest body, SecurityContext securityContext) throws NotFoundException {
    try {
    return Response.ok().entity(generateAPIKey(body.getEmail())).build();
    } catch (final Exception e) {
      return SwaggerUtil.handleException(context, e);
    }
  }

  private ValidateResponse generateAPIKey(String email) {
    final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);

    try {
      //ValidationUtil.email(email, context.getLocale());

      try (final Connection con = context.getPMF().getConnection()) {
        //ValidationUtil.userRegistrationsAllowed(con);

        result = UserUtil.generateAPIKey(con, email);
        //sendMail(UserUtil.generateAPIKey(con, email));
        result.successful(Boolean.TRUE);
        result.addWarningsItem(WarningUtil.ValidationInfoMessage("API key is aangemaakt"));
      }
      // catching exception is allowed here
    } catch (final Exception e) {
      LOGGER.error("Generating API key failed:", e);
      //throw AeriusExceptionConversionUtil.convert(e, context.getLocale());
    }

    result.setWarnings(WarningUtil.WarningValidationMessageNoImplementation());
    return result;
  }

  /*	  private void sendMail(final ScenarioUser user) throws IOException {
  	    final MailMessageData messageData = new MailMessageData(
  	        MessagesEnum.CONNECT_APIKEY_CONFIRM_SUBJECT, MessagesEnum.CONNECT_APIKEY_CONFIRM_BODY,
  	        context.getLocale(), new MailTo(user.getEmailAddress()));
  	    // Yeah, we could set this before generation, but I really don't care about the probable 1 second precision in this case.
  	    final Date creationDate = new Date();
  	    messageData.setReplacement(ReplacementToken.CONNECT_APIKEY, user.getApiKey());
  	    // I would recommend refactoring CALC_CREATION_* stuff to CREATION_* stuff as this is, well, less okay. Something to do on the Master branch.
  	    messageData.setReplacement(ReplacementToken.CALC_CREATION_DATE, MessageTaskClient.getDefaultDateFormatted(creationDate, context.getLocale()));
  	    messageData.setReplacement(ReplacementToken.CALC_CREATION_TIME, MessageTaskClient.getDefaultTimeFormatted(creationDate, context.getLocale()));
  	    MessageTaskClient.startMessageTask(context.getClientFactory(), messageData);
  	  }
  */
}
