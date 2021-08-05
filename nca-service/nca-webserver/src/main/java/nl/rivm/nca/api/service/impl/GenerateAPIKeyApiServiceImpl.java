package nl.rivm.nca.api.service.impl;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.GenerateAPIKeyRequest;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.GenerateAPIKeyApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.api.service.util.ValidationUtil;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;

public class GenerateAPIKeyApiServiceImpl extends GenerateAPIKeyApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(GenerateAPIKeyApiServiceImpl.class);

  private final ApiServiceContext context;

  public GenerateAPIKeyApiServiceImpl() {
    this(new ApiServiceContext());
  }

  GenerateAPIKeyApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response postGenerateAPIKey(GenerateAPIKeyRequest body, SecurityContext securityContext) throws NotFoundException {
    try {
      return Response.ok().entity(generateAPIKey(body.getEmail())).build();
    } catch (final AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
  }

  private ValidateResponse generateAPIKey(String email) throws AeriusException {
    final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
    ScenarioUser user;
    try {
      ValidationUtil.email(email, context.getLocale());
      try (final Connection con = context.getPMF().getConnection()) {
        user = UserUtil.generateAPIKey(con, email);
        // sendMail();
        result.successful(Boolean.TRUE);
      }
      // catching exception is allowed here
    } catch (final Exception e) {
      LOGGER.error("Generating API key failed:", e);
      throw AeriusExceptionConversionUtil.convert(e, context.getLocale());
    }
    result.setWarnings(new ArrayList<ValidationMessage>());
    result.getWarnings().add(WarningUtil.ValidationInfoMessage("your api key is " + user.getApiKey())); //TEMP rely on email in future
    return result;
  }

  private void sendMail(final ScenarioUser user) throws IOException {
    /*
    final MailMessageData messageData = new MailMessageData(
    MessagesEnum.CONNECT_APIKEY_CONFIRM_SUBJECT,
    MessagesEnum.CONNECT_APIKEY_CONFIRM_BODY, context.getLocale(), new
    MailTo(user.getEmailAddress()));
    final Date creationDate = new Date();
    messageData.setReplacement(ReplacementToken.CONNECT_APIKEY,
    user.getApiKey()); // I would recommend refactoring CALC_CREATION_* stuff
    to CREATION_* stuff as this is, well, less okay. Something to do on the
    Master branch.
    messageData.setReplacement(ReplacementToken.CALC_CREATION_DATE,
    MessageTaskClient.getDefaultDateFormatted(creationDate,
    context.getLocale()));
    messageData.setReplacement(ReplacementToken.CALC_CREATION_TIME,
    MessageTaskClient.getDefaultTimeFormatted(creationDate,
    context.getLocale()));
    MessageTaskClient.startMessageTask(context.getClientFactory(),
    messageData);
    */
  }

}
