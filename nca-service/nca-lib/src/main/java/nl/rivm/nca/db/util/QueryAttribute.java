/*
 * Copyright Dutch Ministry of Economic Affairs
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
package nl.rivm.nca.db.util;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Query attribute enum. Makes it harder to create typos in queries (once defined properly). Can be used in combination with {@link QueryBuilder}.
 */
public enum QueryAttribute implements Attribute {

  /**
   * ID for measure
   */
  MEASURES_ID,
  /**
   * API-key
   */
  API_KEY,
  /**
   * The id of a receptor (or hexagon).
   */
  RECEPTOR_ID,
  /**
   * The id of a critical deposition area (area with a certain critical deposition value, like habitat type areas).
   */
  CRITICAL_DEPOSITION_AREA_ID,
  /**
   * A type, e.g.: Habitat type.
   */
  TYPE,
  /**
   * The id of a sector.
   */
  SECTOR_ID,
  /**
   * The id of a GCN sector.
   */
  GCN_SECTOR_ID,
  /**
   * The id of an assessment area (a n2k area).
   */
  ASSESSMENT_AREA_ID,
  /**
   * The id of a habitat type.
   */
  HABITAT_TYPE_ID,
  /**
   * The id of a goal habitat type.
   */
  GOAL_HABITAT_TYPE_ID,
  /**
   * The name of something (like a habitat type).
   */
  NAME,
  /**
   * The name of an assessment area.
   */
  ASSESSMENT_AREA_NAME,
  /**
   * The label of something (like a calculation point).
   */
  LABEL,
  /**
   * Boolean to indicate if a habitat type is designated or not.
   */
  DESIGNATED,
  /**
   * Boolean to indicate if a habitat type is nitrogen-sensitive or not.
   */
  RELEVANT,
  /**
   * The critical deposition value. The amount of deposition around which point a habitat type will start to be affected.
   */
  CRITICAL_DEPOSITION,
  /**
   * The critical level. The level at which point a habitat type will start to be affected. Level is specific to substance type.
   */
  CRITICAL_LEVEL,
  /**
   * A geometry.
   */
  GEOMETRY,
  /**
   * A year.
   */
  YEAR,
  /**
   * The id of a province.
   */
  PROVINCE_AREA_ID,
  /**
   * The average roughness (z0) on a receptor.
   */
  AVERAGE_ROUGHNESS,
  /**
   * The dominant land use on a receptor.
   */
  DOMINANT_LAND_USE,
  /**
   * The distribution of land uses on a receptor.
   */
  LAND_USES,
  /**
   * The distance.
   */
  DISTANCE,
  /**
   * The maximum distance.
   */
  MAX_DISTANCE,
  /**
   * The bounding box (square box containing a geometry).
   */
  BOUNDINGBOX,
  /**
   * The icon type (of a sector for instance).
   */
  ICON_TYPE,
  /**
   * The color of something.
   */
  COLOR,
  /**
   * A reference.
   */
  REFERENCE,
  /**
   * A code.
   */
  CODE,
  /**
   * A description.
   */
  DESCRIPTION,
  /**
   * The heat content of a source(source characteristic).
   */
  HEAT_CONTENT,
  /**
   * The height of a source (source characteristic).
   */
  HEIGHT,
  /**
   * The spread of a source, usually coupled with height (source characteristic).
   */
  SPREAD,
  /**
   * The ID of a substance.
   */
  SUBSTANCE_ID,
  /**
   * The emission factor.
   */
  EMISSION_FACTOR,
  /**
   * The reduction emission factor.
   */
  REDUCTION_FACTOR, REDUCTION_FACTOR_FLOOR, REDUCTION_FACTOR_CELLAR, REDUCTION_FACTOR_TOTAL,
  /**
   * The proportion factor of the total ammonia emissions originating from the floor or cellar
   */
  PROPORTION_FLOOR, PROPORTION_CELLAR,
  /**
   * The ID of a farm animal category.
   */
  FARM_ANIMAL_CATEGORY_ID,
  /**
   * The ID of a farm lodging type.
   */
  FARM_LODGING_TYPE_ID,
  /**
   * The ID of an additional farm lodging system.
   */
  FARM_ADDITIONAL_LODGING_SYSTEM_ID,
  /**
   * The ID of an reductive farm lodging system.
   */
  FARM_REDUCTIVE_LODGING_SYSTEM_ID,
  /**
   * The ID of a farm lodging fodder measure.
   */
  FARM_LODGING_FODDER_MEASURE_ID,
  /**
   * The ID of a farm lodging system definition (BWL-code).
   */
  FARM_LODGING_SYSTEM_DEFINITION_ID,
  /**
   * The ID of an 'other' farm lodging type.
   */
  FARM_OTHER_LODGING_TYPE_ID,
  /**
   * Whether a farm lodging type/system is an air scrubber.
   */
  SCRUBBER,
  /**
   * The coverage of a habitat type.
   */
  COVERAGE,
  /**
   * The surface of an area. (or actually area I guess...)
   */
  SURFACE,
  /**
   * The authority in charge of something.
   */
  AUTHORITY,
  /**
   * The ID of a calculation.
   */
  CALCULATION_ID,
  /**
   * The ID of a custom calculation point (defined by the user, not a receptor).
   */
  CALCULATION_POINT_ID,
  /**
   * The type of a calculation result (deposition, concentration, etc).
   */
  RESULT_TYPE,
  /**
   * A calculation result value.
   */
  RESULT,
  /**
   * The ID of a UserProfile.
   */
  USER_ID,
  /**
   * The ID of an Authority.
   */
  AUTHORITY_ID,
  /**
   * The proposed calculation id.
   */
  PROPOSED_CALCULATION_ID,
  /**
   * The current calculation id.
   */
  CURRENT_CALCULATION_ID,
  /**
   * The zoom level.
   */
  ZOOM_LEVEL,
  /**
   * The x coordinate.
   */
  X_COORD,
  /**
   * The y coordinate.
   */
  Y_COORD,
  /**
   * The buffer to use.
   */
  BUFFER,
  /**
   * Habitat type quality type (1a, 1b, 2)
   */
  HABITAT_QUALITY_TYPE,
  /**
   * Habitat quality goal.
   */
  QUALITY_GOAL,
  /**
   * Habitat extent goal.
   */
  EXTENT_GOAL,
  /**
   * Relevant coverage.
   */
  RELEVANT_COVERAGE,
  /**
   * Relevant surface.
   */
  RELEVANT_SURFACE,
  /**
   * Total cartographic surface.
   */
  CARTOGRAPHIC_SURFACE,
  /**
   * Relevant cartographic surface.
   */
  RELEVANT_CARTOGRAPHIC_SURFACE,
  /**
   * A value e.g. the permit threshold value
   */
  VALUE,
  /**
   * A count e.g. record count
   */
  COUNT,
  /**
   * Development space
   */
  SPACE,
  /**
   * Development space segment
   */
  SEGMENT,
  /**
   * Development space status
   */
  STATUS,

  /**
   * User role ID.
   */
  USERROLE_ID,

  /**
   * Permission ID.
   */
  PERMISSION_ID,

  /**
   * Diurnal variation code.
   */
  EMISSION_DIURNAL_VARIATION_CODE,

  /**
   * Emission diurnal variation ID.
   */
  EMISSION_DIURNAL_VARIATION_ID,

  /**
   * Unique ID for a Job.
   */
  JOB_ID,

  /**
   * A key, e.g: Job key.
   */
  KEY,

  /**
   * Filename of a file.
   */
  FILENAME,

  /**
   * Generic ID.
   */
  ID;

  /**
   * @return the attribute representation as used in most queries.
   */
  @Override
  public String attribute() {
    return name().toLowerCase();
  }

  /**
   * @param rs The resultset to get the value from.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public int getInt(final ResultSet rs) throws SQLException {
    return QueryUtil.getInt(rs, this);
  }

  /**
   * @param rs The resultset to get the value from.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public double getDouble(final ResultSet rs) throws SQLException {
    return QueryUtil.getDouble(rs, this);
  }

  /**
   * @param rs The resultset to get the value from.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public String getString(final ResultSet rs) throws SQLException {
    return QueryUtil.getString(rs, this);
  }

  /**
   * @param rs The resultset to get the value from.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public <E extends Enum<E>> E getEnum(final ResultSet rs, final Class<E> enumClass) throws SQLException {
    return QueryUtil.getEnum(rs, this, enumClass);
  }

  /**
   * @param rs The resultset to get the value from.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public boolean getBoolean(final ResultSet rs) throws SQLException {
    return QueryUtil.getBoolean(rs, this);
  }

  /**
   * @param rs The resultset to get the value from.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public Object getObject(final ResultSet rs) throws SQLException {
    return QueryUtil.getObject(rs, this);
  }

  /**
   * @param rs The resultset to check the null value for.
   * @return Boolean whether the field is null.
   * @throws SQLException In case of a query error.
   */
  public boolean isNull(final ResultSet rs) throws SQLException {
    return QueryUtil.isNull(rs, this);
  }

}
