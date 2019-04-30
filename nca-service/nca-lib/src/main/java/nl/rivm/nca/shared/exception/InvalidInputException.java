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
package nl.rivm.nca.shared.exception;

import java.util.List;

/**
 * Exception to indicate the input is not valid (violates any constraints).
 * Contains a set of messages that describe the violation(s) in question.
 *
 * <p>Exception is meant to be used at the server side only, so no i18n is needed/used here.
 */
public class InvalidInputException extends AeriusException {

  private static final long serialVersionUID = 1228512752509314576L;
  private final List<String> violationMessages;

  public InvalidInputException(final List<String> violationMessages) {
    this.violationMessages = violationMessages;
  }

  public void merge(final InvalidInputException e) {
    this.violationMessages.addAll(e.getConstraintViolations());
  }

  public List<String> getConstraintViolations() {
    return violationMessages;
  }

  @Override
  public String getMessage() {
    final StringBuilder message = new StringBuilder();
    for (final String violationMessage : violationMessages) {
      message.append(violationMessage);
      message.append(". ");
    }
    return message.toString();
  }

  @Override
  public String toString() {
    return super.toString() + getMessage();
  }

}
