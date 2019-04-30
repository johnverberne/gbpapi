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

import java.util.Locale;

import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

/**
 * Util to convert exceptions to {@link AeriusException}.
 * An {@link AeriusException} is an exception with an error code and a user friendly error message.
 */
public final class AeriusExceptionConversionUtil {

  private AeriusExceptionConversionUtil() {
    // util class.
  }

  /**
   * Converts an Exception to a {@link AeriusException}.
   * @param e exception
   * @param context Context to get locale for customized message.
   * @return {@link AeriusConnectException}
   */
  public static AeriusException convert(final Exception e, final ApiServiceContext context) {
    return convert(e, context.getLocale());
  }

  /**
   * Converts an Exception to a {@link AeriusException}.
   * @param e exception
   * @param locale locale for customized message.
   * @return {@link AeriusException}
   */
  public static AeriusException convert(final Exception e, final Locale locale) {
    if (e instanceof AeriusException) {
      return (AeriusException) e;
    }
    return convert(ValidationMessageUtil.convert(e, locale));
  }

  /**
   * Converts a {@link ValidationMessage} to a {@link AeriusException}.
   * @param vm {@link ValidationMessage}
   * @return {@link AeriusException}
   */
  public static AeriusException convert(final ValidationMessage vm) {
    return new AeriusException(Reason.fromErrorCode(vm.getCode()), vm.getMessage());
  }
}
