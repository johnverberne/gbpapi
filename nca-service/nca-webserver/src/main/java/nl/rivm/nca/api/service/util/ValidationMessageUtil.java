/*
 * Copyright the State of the Netherlands
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses/.
 */
package nl.rivm.nca.api.service.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.shared.exception.AeriusException;



/**
 * Util class to convert {@link AeriusException} to a {@link ValidationMessage}.
 */
public final class ValidationMessageUtil {

  private ValidationMessageUtil() {
  }

  /**
   * Converts an Exception to a {@link ValidationMessage}.
   * @param e exception
   * @param locale locale for customized message.
   * @return {@link ValidationMessage}
   */
  public static ValidationMessage convert(final Exception e, final Locale locale) {
    final int reason = (e instanceof AeriusException ? ((AeriusException) e).getReason() : AeriusException.Reason.INTERNAL_ERROR).getErrorCode();
    final String message = e.toString(); //new AeriusExceptionMessages(locale).getString(e);

    return new ValidationMessage().code(reason).message(message);
  }

  /**
   * Converts a list of {@link AeriusException}s to a list of {@link ValidationMessage}s.
   * @param exceptions list of {@link AeriusException}s
   * @param locale locale for customized message.
   * @return list of {@link ValidationMessage}s
   */
  public static List<ValidationMessage> convert(final ArrayList<AeriusException> exceptions, final Locale locale) {
    final List<ValidationMessage> errors = new ArrayList<>();
    for (final AeriusException ae : exceptions) {
      errors.add(new ValidationMessage().code(ae.getReason().getErrorCode()).message(ae.getLocalizedMessage())); //new AeriusExceptionMessages(locale).getString(ae)));
    }
    return errors;
  }
}
