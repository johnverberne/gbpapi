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
     * @param 0 name of the project
     */
    CALCULATION_NO_SOURCES(1001),
    /**
     * A value in the emission source had an invalid value.
     *
     * @param 0 name of the emission source
     * @param 1 failure message
     * @param 2 value that failed
     */
    SOURCE_VALIDATION_FAILED(1002),
    /**
     * Number of sources exceeds maximum.
     *
     * @param 0 maximum number of allowed sources
     * @param 1 name of the source
     */
    LIMIT_SOURCES_EXCEEDED(1003),
    /**
     * Length of a line exceeds maximum length.
     *
     * @param 0 name of the source
     * @param 1 allowed maximum line length
     * @param 2 length of source
     */
    LIMIT_LINE_LENGTH_EXCEEDED(1004),
    /**
     * Surface of a polygon exceeds maximum surface.
     *
     * @param 0 name of the source
     * @param 1 allowed maximum surface
     * @param 2 surface of source
     */
    LIMIT_POLYGON_SURFACE_EXCEEDED(1005),
    /**
     * @param 0 ship type that is not allowed.
     * @param 1 name of the waterway type. For some waterways there is a restriction on which ship types are allowed.
     */
    INLAND_SHIPPING_SHIP_TYPE_NOT_ALLOWED(1006),
    /**
     * Shipping routes are only allowed to be LineStrings.
     */
    SHIPPING_ROUTE_GEOMETRY_NOT_ALLOWED(1007),
    /**
     * Geocoder call failed.
     */
    GEOCODER_ERROR(1008),
    /**
     * Calculation to complex for calculator (to many engine sources to calculate).
     *
     * @param 0 name of the project
     */
    CALCULATION_TO_COMPLEX(1009),
    /**
     * Roads are only allowed to be LineStrings, or networks containing LineStrings.
     */
    ROAD_GEOMETRY_NOT_ALLOWED(1010),
    /**
     * A Research Area calculation is requested but there are no sources in the research area.
     */
    CALCULATION_NO_RESEARCH_AREA(1011),
    /**
     * Length of a line length 0.
     *
     * @param 0 name of the source
     */
    LIMIT_LINE_LENGTH_ZERO(1012),
    /**
     * Surface of a polygon surface 0.
     *
     * @param 0 name of the source
     */
    LIMIT_POLYGON_SURFACE_ZERO(1013),
    /**
     * Upon determining the water way type of a route, multiple types were found.
     *
     * @param 0 id of the emission source
     * @param 1 name of chosen water way
     * @param 2 list of other water ways found
     */
    INLAND_SHIPPING_WATERWAY_INCONCLUSIVE(1014),
    /**
     * No watery direction or incorrect is given for the waterway type.
     *
     * @param 0 water way
     * @param 1 invalid direction
     */
    INLAND_SHIPPING_WATERWAY_NO_DIRECTION(1015),
    /**
     * Shipping objects can only be calculated with OPS, so when a sector that is calculated with another model (SRM2) this is not valid.
     * This should only happen if a user assigns a road sector id to a shipping emission object. If not throwing the error ops sources
     * would be passed to the SRM2 worker that would then shutdown.
     *
     * @param 0 label of shipping source
     * @param 1 sector name
     * @param 2 sector id
     */
    SHIPPING_INVALID_SECTOR(1016),

    // Import errors
    /**
     * The POST doesn't contain an file to import.
     */
    IMPORT_FILE_NOT_SUPPLIED(5001),
    /**
     * The file could not be read.
     */
    IMPORT_FILE_COULD_NOT_BE_READ(5002),
    /**
     * The request to the server contains invalid values in the POST and could not be processed.
     */
    FAULTY_REQUEST(5003),
    /**
     * The file to be imported is not supported.
     */
    IMPORT_FILE_UNSUPPORTED(5004),
    /**
     * The file with extension to be imported is not allowed. The import functionality that throws this would like the user to know that only specific
     * extensions/filetypes are allowed..
     */
    IMPORT_FILE_TYPE_NOT_ALLOWED(5005),
    /**
     * Uploaded file is missing the required ID.
     */
    IMPORT_REQUIRED_ID_MISSING(5006),
    /**
     * Uploaded entry is a duplicate and cannot be imported.
     */
    IMPORT_DUPLICATE_ENTRY(5007),
    /**
     * Uploaded file should contain sources and has none.
     */
    IMPORT_NO_SOURCES_PRESENT(5008),
    /**
     * Uploaded file should contain results and has none.
     *
     * @param 0 reference
     */
    IMPORT_NO_RESULTS_PRESENT(5009),
    /**
     * Uploaded file should contain calculation points and has none.
     */
    IMPORT_NO_CALCULATION_POINTS_PRESENT(5010),
    /**
     * The supplied received date is not valid.
     */
    IMPORT_NO_VALID_RECEIVED_DATE(5011),

    /**
     * Used when actual reason for the exception when reading a row in a file is unknown.
     *
     * @param 0 line number
     */
    IO_EXCEPTION_UNKNOWN(5050),
    /**
     * Used when a number is incorrectly formatted in the file.
     *
     * @param 0 line number
     * @param 1 column name
     * @param 2 column content
     */
    IO_EXCEPTION_NUMBER_FORMAT(5051),
    /**
     * Used when a row does not have enough fields.
     *
     * @param 0 line number
     */
    IO_EXCEPTION_NOT_ENOUGH_FIELDS(5052),

    // Import BRN file errors.
    /**
     * A .BRN file is supplied without a substance (required).
     */
    BRN_WITHOUT_SUBSTANCE(5101),
    /**
     * A substance is supplied that is not supported.
     *
     * @param 0 substance given as input
     * @param 1 list of allowed substances.
     */
    BRN_SUBSTANCE_NOT_SUPPORTED(5102),

    // Import GML file errors/warnings.

    /**
     * GML validation failed.
     *
     * @param 0 raw errors from validator.
     */
    GML_VALIDATION_FAILED(5201),
    /**
     * Geometry in gml is invalid.
     *
     * @param 0 the id of the object containing an invalid geometry.
     */
    GML_GEOMETRY_INVALID(5202),
    /**
     * Encoding in GML is not supported.
     */
    GML_ENCODING_INCORRECT(5203),
    /**
     * Geometry in gml intersects with self.
     *
     * @param 0 name of the source containing the intersecting geometry
     * @param 1 type of the geometry, line or polygon
     */
    GML_GEOMETRY_INTERSECTS(5204),
    /**
     * Geometry in gml is not permitted for that particular source type.
     *
     * @param 0 the id of the object containing the error.
     */
    GML_GEOMETRY_NOT_PERMITTED(5205),
    /**
     * Geometry in gml is not supported.
     *
     * @param 0 the id of the object containing the error.
     */
    GML_GEOMETRY_UNKNOWN(5206),
    /**
     * GML contains a unknown RAV code.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is unknown.
     */
    GML_UNKNOWN_RAV_CODE(5207),
    /**
     * GML contains a unknown mobile source code.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is unknown.
     */
    GML_UNKNOWN_MOBILE_SOURCE_CODE(5208),
    /**
     * GML contains a unknown ship code.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is unknown.
     */
    GML_UNKNOWN_SHIP_CODE(5209),
    /**
     * GML contains a unknown plan code.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is unknown.
     */
    GML_UNKNOWN_PLAN_CODE(5210),
    /**
     * GML parsing failed, but AERIUS could not parse the error message.
     *
     * @param 0 user-unfriendly internal error message
     */
    GML_GENERIC_PARSE_ERROR(5211),
    /**
     * GML file contains a parse error.
     *
     * @param 0 row in error
     * @param 1 column in error
     * @param 2 value in error
     * @param 3 expected value
     */
    GML_PARSE_ERROR(5212),
    /**
     * IMAER version in GML not recognized (or not supported anymore).
     *
     * @param 0 namespace uri used to determine version
     */
    GML_VERSION_NOT_SUPPORTED(5213),
    /**
     * Building the GML file failed.
     *
     * @param 0 raw error message from jaxb parser.
     */
    GML_CREATION_FAILED(5214),
    /**
     * Geometry is invalid.
     *
     * @param 0 the invalid geometry.
     */
    GEOMETRY_INVALID(5215),
    /**
     * GML contains an unknown PAS-measure code.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is unknown.
     */
    GML_UNKNOWN_PAS_MEASURE_CODE(5216),
    /**
     * GML contains a PAS-measure that can not be applied to the lodging system.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is invalid.
     * @param 2 The code of the farm lodging system
     */
    GML_INVALID_PAS_MEASURE_CATEGORY(5217),
    /**
     * While importing the old category could not correctly matched with a new category.
     *
     * @param 0 the label of the source.
     * @param 1 the offending category code.
     * @param 2 the category code used.
     */
    GML_INVALID_CATEGORY_MATCH(5218),
    /**
     * While importing a road source the old category could not correctly matched with a new category.
     *
     * @param 0 the label of the source.
     * @param 1 the offending category code.
     * @param 2 the category code used.
     */
    GML_INVALID_ROAD_CATEGORY_MATCH(5219),

    /**
     * The source id string contains a number that already is used on another id, while the string id itself might be unique.
     *
     * @param 0 violating id.
     * @param 1 id that is violated.
     */
    GML_ID_NOT_UNIQUE(5220),
    /**
     * GML contains an unknown combination of road characteristics that don't match a known vehicle category.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 road sector
     * @param 2 road speed
     * @param 3 strict enforcement
     * @param 4 road vehicle category
     */
    GML_UNKNOWN_ROAD_CATEGORY(5221),
    /**
     * GML meta data field may not be empty.
     *
     * @param 0 the meta data field found to be empty
     */
    GML_METADATA_EMPTY(5222),
    /**
     * Warning GML version is not the latest version.
     */
    GML_VERSION_NOT_LATEST(5223),
    /**
     * Warning GML all emission values are zero.
     */
    GML_SOURCE_NO_EMISSION(5224),
    /**
     * The srsName used in GML is unsupported.
     *
     * @param 0 the unsupported SRS name.
     */
    GML_SRS_NAME_UNSUPPORTED(5225),
    /**
     * Warning GML source has no vehicles.
     *
     * @param 0 label of the source
     */
    SRM2_SOURCE_NO_VEHICLES(5226),
    /**
     * GML contains a unknown waterway code.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code that is unknown.
     */
    GML_UNKNOWN_WATERWAY_CODE(5227),
    /**
     * GML contains an invalid ship/waterway combination.
     *
     * @param 0 the id of the object containing the error.
     * @param 1 The code of the ship.
     * @param 2 The code of the waterway.
     */
    GML_INVALID_SHIP_FOR_WATERWAY(5228),
    /**
     * Warning that the waterway is not set for an inland shipping source.
     *
     * @param 0 The label of the source containing the error.
     */
    GML_INLAND_WATERWAY_NOT_SET(5229),
    /**
     * Error that the road vehicles are negative.
     *
     * @param 0 the id of the object containing the error.
     */
    SRM2_SOURCE_NEGATIVE_VEHICLES(5230),

    /**
     * Error, road segment position was not a fraction (0-1)
     */
    GML_ROAD_SEGMENT_POSITION_NOT_FRACTION(5231),

    // Import PAA file errors.
    /**
     * The validation for importing a PDF failed (incorrect metadata in PDF).
     */
    PAA_VALIDATION_FAILED(5301),

    // Import ZIP file errors.

    /**
     * ZIP archive file does not contain any useable files.
     */
    ZIP_WITHOUT_USABLE_FILES(5401),
    /**
     * ZIP archive file contains to many useable files.
     */
    ZIP_TOO_MANY_USABLE_FILES(5402),

    // OPS file and calculation errors.

    /**
     * OPS run failed with error.
     *
     * @param 0 ops message
     */
    OPS_INTERNAL_EXCEPTION(6101),
    /**
     * OPS was fed with input that is outside the expected scope of ops
     *
     * @param 0 the validation errors
     */
    OPS_INPUT_VALIDATION(6102),

    // Standard file parsing errors.

    // SRM2 file and calculation errors.
    /**
     * Could not find road properties for given road type.
     *
     * @param 0 line number
     * @param 1 column content
     * @param 2 found road parameters
     */
    SRM2IO_EXCEPTION_NO_ROAD_PROPERTIES(6201),
    /**
     * The current hardware can't calculate the given number of sources.
     *
     * @param 0 number of input sources
     */
    SRM2_TO_MANY_ROAD_SEGMENTS(6202),
    /**
     * There is no pre-processed meteo and background data from presrm for the given year.
     *
     * @param 0 year to be calculated
     */
    SRM2_NO_PRESRM_DATA_FOR_YEAR(6203),
    /**
     * Could not find expected column header(s) in the specified file.
     *
     * @param 0 column(s) that were expected
     */
    SRM2_MISSING_COLUMN_HEADER(6204),
    /**
     * Column contained incorrect (empty or unparseable) value in the specified file.
     *
     * @param 0 line number
     * @param 1 column for which a value was expected
     */
    SRM2_INCORRECT_EXPECTED_VALUE(6205),
    /**
     * Could not parse the WKT value in the specified file as a LineString.
     *
     * @param 0 line number
     * @param 1 value that couldn't be parsed as a LineString.
     */
    SRM2_INCORRECT_WKT_VALUE(6206),

    /**
     * Warning CSV file support is not supported we be remove in future.
     *
     */
    SRM2_FILESUPPORT_WILL_BE_REMOVED(6207),

    /**
     * Warning source tunnel factor 0 and therefore is ignored.
     *
     * @param 0 actual tunnel factor
     * @param 1 label of the source
     */
    SRM2_SOURCE_TUNNEL_FACTOR_ZERO(6209),
    /**
     * Error when network id's in the GML don't match up with sources.
     *
     * @param 0 the id of the road source not found in network
     */
    SRM2_ROAD_NOT_IN_NETWORK(6210),

    // Register Errors starts at 20000

    /**
     * Request already exists in the (register) database.
     *
     * @param 0 AERIUS reference of the scenario
     */
    REQUEST_ALREADY_EXISTS(20001),
    /**
     * Scenario does not exist in the (register) database.
     *
     * @param 0 dossier id of the scenario
     */
    PERMIT_UNKNOWN(20002),
    /**
     * Permit is already updated and we're trying to update over an older version.
     *
     * @param 0 dossier id
     */
    PERMIT_ALREADY_UPDATED(20004),
    /**
     * Attempting to assign a permit for which there is no development room.
     *
     * @param dossier id
     */
    PERMIT_DOES_NOT_FIT(20005),
    /**
     * No authorization to delete an active permit.
     *
     * @param dossier id
     */
    PERMIT_DELETE_ACTIVE_NO_AUTHORIZATION(20006),
    /**
     * No authorization to dequeue a permit.
     *
     * @param dossier id
     */
    PERMIT_DEQUEUE_NO_AUTHORIZATION(20007),
    /**
     * No authorization to enqueue a permit.
     *
     * @param dossier id
     */
    PERMIT_ENQUEUE_NO_AUTHORIZATION(20008),
    /**
     * Melding does not fit the required space.
     */
    MELDING_DOES_NOT_FIT(20011),
    /**
     * Melding is not actually a melding (above permit threshold).
     */
    MELDING_ABOVE_PERMIT_THRESHOLD(20013),
    /**
     * User accesses melding page directly. should go through calculator.
     */
    MELDING_NOT_VIA_CALCULATOR(20016),
    /**
     * User accesses melding page directly. should go through calculator.
     */
    MELDING_ATTACHMENTS_FOR_AUTHORIZATION_TO_BIG(20017),
    /**
     * Priority project does not exist in the (register) database.
     *
     * @param 0 dossier id of the priority project
     */
    PRIORITY_PROJECT_UNKNOWN(20018),
    /**
     * Priority subproject does not exist in the (register) database.
     *
     * @param 0 reference of the priority subproject
     */
    PRIORITY_SUBPROJECT_UNKNOWN(20019),
    /**
     * Melding does not exist in the (register) database.
     *
     * @param 0 reference of the melding
     */
    MELDING_UNKNOWN(20020),
    /**
     * Priority Project reservation doesn't fit.
     */
    PRIORITY_PROJECT_DOES_NOT_FIT(20022),
    /**
     * Reference is not a valid AERIUS reference.
     *
     * @param 0 The invalid reference.
     */
    REQUEST_INVALID_REFERENCE(20023),
    /**
     * Priority Sub Project doesn't fit.
     */
    PRIORITY_SUBPROJECT_DOES_NOT_FIT(20024),
    /**
     * A non-allowed sector has been found in the IMAER file whilst uploading a priority project (any type).
     */
    PRIORITY_PROJECT_NON_ALLOWED_SECTOR(20025),

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
     * The user does not have the permission to export the priority project
     */
    USER_PRIORITY_PROJECT_UTILISATION_EXPORT_NOT_ALLOWED(40011),

    // Connect Application errors start at 50000

    /**
     * The email is not supplied.
     *
     * @param 0 given email address
     */
    CONNECT_NO_VALID_EMAIL_SUPPLIED(50001),
    /**
     * The calculation year is incorrect.
     *
     * @oaram 0 given year
     */
    CONNECT_INCORRECT_CALCULATIONYEAR(50002),
    /**
     * The calculation type is not supplied.
     */
    CONNECT_NO_CALCULATIONTYPE_SUPPLIED(50003),
    /**
     * The calculation substance is not supplied.
     */
    CONNECT_NO_SUBSTANCE_SUPPLIED(50004),
    /**
     * The calculation distance range is invalid.
     *
     * @param 0 invalid given calculation distance
     */
    CONNECT_INVALID_CALCULATION_RANGE(50005),
    /**
     * The calculation temp years range is invalid.
     *
     * @param 0 invalid given temp year
     * @param 1 minimum years
     * @param 2 maximum years
     */
    CONNECT_INVALID_TEMPPROJECT_RANGE(50006),
    /**
     * No input sources specified.
     */
    CONNECT_NO_SOURCES(50007),
    /**
     * A Connect report API call is made without supplying a proposed situation.
     */
    CONNECT_REPORT_NO_PROPOSED(50008),
    /**
     * The calculation type is temporary not supported.
     */
    CONNECT_CALCULATIONTYPE_SUPPLIED_NOT_SUPPORTED(50009),
    /**
     * The calculation type is temporary not supported.
     */
    CONNECT_REPORT_PERMIT_DEMAND_COMPARISON_NOT_SUPPORTED(50010),
    /**
     * An unsupported substance or typo in the substance was passed.
     */
    CONNECT_UNKNOWN_SUBSTANCE_SUPPLIED(50011),
    /**
     * The user does not have a job with the the supplied jobkey
     */
    CONNECT_USER_JOBKEY_DOES_NOT_EXIST(50012),
    /**
     * cancel the connect calculation job
     */
    CONNECT_JOB_CANCELLED(50013),
    /**
     * The passed parameter did not any receptors.
     *
     */
    CONNECT_NO_RECEPTORS_IN_PARAMETERS(50014),
    /**
     * UserCalculationPointSet already exists in the database.
     *
     * @param 0 setname
     */
    CONNECT_USER_CALCULATION_POINT_SET_ALREADY_EXISTS(50015),
    /**
     * UserCalculationPointSet does not exist in the database.
     *
     * @param 0 setname
     */
    CONNECT_USER_CALCULATION_POINT_SET_DOES_NOT_EXIST(50016),
    /**
     * An unsupported DataType was chosen for an operation.
     *
     */
    CONNECT_UNSUPPORTED_DATATYPE_IN_OPERATION(50017),

    // Scenario Application-specific errors start at 60000

    /**
     * An I/O error has occurred while trying to communicate with the API.
     *
     * @param 0 detailed error message.
     */
    SCENARIO_API_CONNECTION_ERROR(60001);

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
  public AeriusException() {}

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
