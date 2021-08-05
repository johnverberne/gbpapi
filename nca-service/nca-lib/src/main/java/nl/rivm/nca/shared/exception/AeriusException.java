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

import java.io.Serializable;
import java.util.Date;

/**
 * An exception thrown by a server side application and is caused by an error related to the specific input of the user or an unrecoverable error that
 * can not be handled. An AeriusException always contains a {@link Reason} and optional parameters with relevant context specific values. It should
 * not contain any language specific or message related data as argument. On the client or elsewhere the message is processed the language specific
 * message is obtained based on the reason code and additional data values are passed into the message.
 */
public class AeriusException extends Exception implements Serializable {
  private static final long serialVersionUID = 4336548764880899435L;

  /**
   * Enum with a list of errors that can be returned by the server via a {@link AeriusException}. Each reason should state in the JavaDoc the
   * arguments to be passed. It is not enforced at compile time if this matches, therefore be careful and test it.
   */
  public enum Reason {

    // Internal errors codes < 1000, these will be interpreted as such. USE WISELY!

    /**
     * Unspecified internal server error.
     */
    INTERNAL_ERROR(666),
    /**
     * Database error. Can be incorrect query or missing database connection.
     */
    SQL_ERROR(667),
    /**
     * Database content error. For worker to test required database constants.
     */
    SQL_ERROR_CONSTANTS_MISSING(668),

    // Generic calculator errors start at 1000
    /**
     * Trying to start a calculation but there are no sources to calculate.
     *
     */
    CALCULATION_NO_SOURCES(1001),
    /**
     * Trying to start a calculation but specified a measure that does not exist.
     *
     * @param 0 name of the measure
     */
    CALCULATION_NO_MEASURE(1002),
    /**
     * Trying write new measureCollection but the name already exists.
     *
     * @param 0 name of the measure
     */
    CALCULATION_MEASURE_NAME_ALREADY_EXISTS(1003),
    /**
     * Trying delete measureCollection but does not exists.
     *
     * @param 0 name of the measure
     */
    CALCULATION_MEASURE_NAME_DOES_NOT_EXISTS(1004),
    
    // Authorization & Authentication and User management errors (across applications).
    /**
     * Authorization error. Does not have the required permissions.
     */
    AUTHORIZATION_ERROR(40001),

    /**
     * User already exists in the (register) database.
     *
     * @param 0 username
     */
    USER_ALREADY_EXISTS(40002),

    /**
     * User does not exist in the (register) database.
     *
     * @param 0 username
     */
    USER_DOES_NOT_EXIST(40003),

    /**
     * User can not be deleted from (register) database (foreign key violation).
     */
    USER_CANNOT_BE_DELETED(40004),

    /**
     * An email address is already registered in the user list.
     *
     * @param 0 email address
     */
    USER_EMAIL_ADDRESS_ALREADY_EXISTS(40005),
    
    /**
     * An API key is already registered in the user list.
     */
    USER_API_KEY_ALREADY_EXISTS(40006),
    
    /**
     * The API key doesn't belong to an user.
     */
    USER_INVALID_API_KEY(40007),
    
    /**
     * API key generation is disabled.
     */
    USER_API_KEY_GENERATION_DISABLED(40008),
    
    /**
     * The user reached his max concurrent jobs.
     */
    USER_MAX_CONCURRENT_JOB_LIMIT_REACHED(40009),
    
    /**
     * The user account is disabled.
     */
    USER_ACCOUNT_DISABLED(40010),
    
    /**
     * The email is not supplied or not valid format
     */
    CONNECT_NO_VALID_EMAIL_SUPPLIED(50001);

    private final int errorCode;

    Reason(final int errorCode) {
      this.errorCode = errorCode;
    }

    /**
     * @param errorCode The error code to resolve.
     * @return The reason object for the given error code, or null if the error code was unknown.
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
