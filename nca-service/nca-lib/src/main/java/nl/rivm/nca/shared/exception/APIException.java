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

/**
 * Simple wrapper around AeriusException that is specific for API calls and its response behaviour.
 *
 * API calls do not supply args, and instead supply a fully formatted error message.
 *
 * This Exception is meant to represent that formatted error, while also extracting the Reason from the error code which we can use to give better
 * context to the message.
 */
public class APIException extends AeriusException {
  private static final long serialVersionUID = 8594294690662856704L;

  public APIException() {}

  public APIException(final Reason reason, final String message) {
    super(reason, message);
  }

  @Override
  public String getMessage() {
    return getArgs()[0];
  }
}
