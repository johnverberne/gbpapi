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
package nl.rivm.nca.exception;

import java.io.Serializable;
import java.util.Date;

 * An exception thrown by a server side application and is caused by an error
 * related to the specific input of the user or an unrecoverable error that can
 * not be handled. An AeriusException always contains a {@link Reason} and
 * optional parameters with relevant context specific values. It should not
 * contain any language specific or message related data as argument. On the
 * client or elsewhere the message is processed the language specific message is
 * obtained based on the reason code and additional data values are passed into
 * the message.
 */
public class AeriusException extends Exception implements Serializable {
	private static final long serialVersionUID = 4336548764880899435L;

	/**
	 * Enum with a list of errors that can be returned by the server via a
	 * {@link AeriusException}. Each reason should state in the JavaDoc the
	 * arguments to be passed. It is not enforced at compile time if this
	 * matches, therefore be careful and test it.
	 */
	public enum Reason {

		// Internal errors codes < 1000, these will be interpreted as such. USE
		// WISELY!

		/**
		 * Unspecified internal server error.
		 */
		INTERNAL_ERROR(666),
		/**
		 * Database error. Can be incorrect query or missing database
		 * connection.
		 */
		SQL_ERROR(667),
		/**
		 * Database content error. For worker to test required database
		 * constants.
		 */
		SQL_ERROR_CONSTANTS_MISSING(668),
		/**
		 * Database content error. The user does exist.
		 */
		USER_ALREADY_EXISTS(1000), 
		USER_EMAIL_ADDRESS_ALREADY_EXISTS(1001), 
		USER_API_KEY_ALREADY_EXISTS(1002), 
		USER_INVALID_API_KEY(1003), 
		USER_ACCOUNT_DISABLED(1004), 
		CONNECT_NO_VALID_EMAIL_SUPPLIED(1005), 
		CONNECT_USER_JOBKEY_DOES_NOT_EXIST(1006)
		;

		private final int errorCode;

		Reason(final int errorCode) {
			this.errorCode = errorCode;
		}

		/**
		 * @param errorCode
		 *            The error code to resolve.
		 * @return The reason object for the given error code, or null if the
		 *         error code was unknown.
		 */
		public static Reason fromErrorCode(final int errorCode) {
			for (final Reason reason : Reason.values()) {
				if (reason.getErrorCode() == errorCode) {
					return reason;
				}
			}

			return null;
		}

		public int getErrorCode() {
			return errorCode;
		}

		public String getErrorCodeKey() {
			return "e" + errorCode;
		}
	}

	private static final int INTERNAL_ERROR_MAX_VALUE = 999;

	private Reason reason;
	private long reference;
	private String[] args;

	// Needed for GWT.
	public AeriusException() {
	}

	public AeriusException(final Reason errorCode, final String... args) {
		super();
		this.reason = errorCode;
		this.reference = new Date().getTime();
		this.args = args;
	}

	public boolean isInternalError() {
		return reason.getErrorCode() <= INTERNAL_ERROR_MAX_VALUE;
	}

	public Reason getReason() {
		return reason;
	}

	public long getReference() {
		return reference;
	}

	public String[] getArgs() {
		return args;
	}

	@Override
	public String getMessage() {
		return toString();
	}

	@Override
	public String toString() {
		final StringBuilder str = new StringBuilder(64);

		str.append("[errorCode=").append(reason).append(",reference=").append(reference).append(",args=[");
		if (args != null) {
			for (int i = 0; i < args.length; ++i) {
				if (i != 0) {
					str.append(',');
				}
				str.append(args[i]);
			}
		}
		str.append("]];");
		return str.toString();
	}

}
