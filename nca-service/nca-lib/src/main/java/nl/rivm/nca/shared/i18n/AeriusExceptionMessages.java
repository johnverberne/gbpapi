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
package nl.rivm.nca.shared.i18n;

import java.io.Serializable;
import java.util.Enumeration;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

/**
 * Resource bundle for AeriusExceptionMessages.
 */
public class AeriusExceptionMessages extends ResourceBundle implements Serializable {

  private static final long serialVersionUID = -3690261560161474905L;

  private static final String AERIUS_EXCEPTION_MESSAGES = AeriusExceptionMessages.class.getName();

  public AeriusExceptionMessages(final Locale locale) {
    setLocale(locale);
  }

  public String getString(final AeriusException ae) {
    String message;
    try {
      message = getString(ae.getReason().getErrorCodeKey());
      for (int i = 0; i < ae.getArgs().length; i++) {
        message = message.replace("{" + i + "}", ae.getArgs()[i] == null ? "null" : ae.getArgs()[i]);
      }
    } catch (final MissingResourceException e) {
      message = getString(Reason.INTERNAL_ERROR.getErrorCodeKey());
    }
    return message;
  }

  public String getString(final Throwable ae) {
    return ae instanceof AeriusException ? getString((AeriusException) ae) : getString(Reason.INTERNAL_ERROR.getErrorCodeKey());
  }

  @Override
  protected Object handleGetObject(final String key) {
    return parent.getObject(key);
  }

  @Override
  public Enumeration<String> getKeys() {
    return parent.getKeys();
  }

  private void setLocale(final Locale locale) {
    if (parent == null || !parent.getLocale().equals(locale)) {
      setParent(getBundle(AERIUS_EXCEPTION_MESSAGES, locale));
    }
  }
}
