package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.GenerateAPIKeyRequest;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.service.GenerateAPIKeyApiService;
import nl.rivm.nca.api.service.NotFoundException;

public class GenerateAPIKeyApiServiceImpl extends GenerateAPIKeyApiService {
    @Override
    public Response postGenerateAPIKey(GenerateAPIKeyRequest body, SecurityContext securityContext) throws NotFoundException {
        // do some magic!
        return Response.ok().entity(generateAPIKey(body.getEmail())).build();
    }

	private ValidateResponse generateAPIKey(String email) {
	    final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
/*
	    try {
	      ValidationUtil.email(email, context.getLocale());

	      try (final Connection con = context.getPMF().getConnection()) {
	        ValidationUtil.userRegistrationsAllowed(con);

	        sendMail(UserUtil.generateAPIKey(con, email));
	        result.successful(Boolean.TRUE);
	      }
	      // catching exception is allowed here
	    } catch (final Exception e) {
	      LOG.error("Generating API key failed:", e);
	      throw AeriusExceptionConversionUtil.convert(e, context.getLocale());
	    }
*/
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
