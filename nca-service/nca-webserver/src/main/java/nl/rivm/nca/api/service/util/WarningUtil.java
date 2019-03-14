package nl.rivm.nca.api.service.util;

import java.util.ArrayList;
import java.util.List;

import nl.rivm.nca.api.domain.ValidationMessage;

public class WarningUtil {

	private static final int WARNING_NO_IMPLEMENTATION = 001;
	 private static final int WARNING_INFO_MESSAGE = 002;

	/**
	 * Create complete warning object with info nog implemented yet
	 *  
	 * @return list List<ValidationMessage>
	 */
	 
	public static List<ValidationMessage> WarningValidationMessageNoImplementation() {
		List<ValidationMessage> warnings = new ArrayList<ValidationMessage>();
		ValidationMessage message = new ValidationMessage();
		message.setCode(WARNING_NO_IMPLEMENTATION);
		message.setMessage("Nog niet geimplementeerd");
		warnings.add(message);
		return warnings;
	}

	/**
	 * Create a single warning message as info
	 * 
	 * @param msg text string
	 * @return ValidationMessage
	 */
	 public static ValidationMessage ValidationInfoMessage(String msg) {
	    ValidationMessage message = new ValidationMessage();
	    message.setCode(WARNING_INFO_MESSAGE);
	    message.setMessage(msg);
	    return message;
	  }
	 
	
}
