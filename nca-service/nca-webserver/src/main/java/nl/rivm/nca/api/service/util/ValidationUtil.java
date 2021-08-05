package nl.rivm.nca.api.service.util;

import java.util.Locale;

import com.google.gwt.regexp.shared.RegExp;

import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

public class ValidationUtil {
  public static final String VALID_EMAIL_ADDRESS_REGEX =
      "^[\\w\\u00C0-\\u02AF-\\+]+(\\.[\\w\\u00C0-\\u02AF-]+)*@[\\w\\u00C0-\\u02AF-]+(\\.[\\w\\u00C0-\\u02AF]+)*(\\.[A-Za-z]{2,})$";
  private static final RegExp EMAIL_REG_EXP = RegExp.compile(VALID_EMAIL_ADDRESS_REGEX, "i");

  private ValidationUtil() {
    // util class
  }

  /**
   * Validates the email address.
   * @param emailAddress email address
   * @param locale the locale to be used in case of an error
   * @throws AeriusException throws exception in case of validation errors
   */
  public static void email(final String emailAddress, final Locale locale) throws AeriusException {
    if (emailAddress == null || emailAddress.length() == 0 || EMAIL_REG_EXP.exec(emailAddress.trim()) == null) {
      throw new AeriusException(Reason.CONNECT_NO_VALID_EMAIL_SUPPLIED, emailAddress);
    }
  }
    
}
