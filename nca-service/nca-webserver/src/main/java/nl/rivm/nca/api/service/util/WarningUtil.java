package nl.rivm.nca.api.service.util;

import java.util.ArrayList;
import java.util.List;

import nl.rivm.nca.api.domain.ValidationMessage;

public class WarningUtil {

	private static final int WARNING_NO_IMPLEMENTATION = 001;

	public static List<ValidationMessage> WarningValidationMessageNoImplementation() {
		List<ValidationMessage> warnings = new ArrayList<ValidationMessage>();
		ValidationMessage message = new ValidationMessage();
		message.setCode(WARNING_NO_IMPLEMENTATION);
		message.setMessage("Nog niet geimplementeerd");
		warnings.add(message);
		return warnings;
	}

}
