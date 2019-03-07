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

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import nl.rivm.nca.util.EnumUtil;
import nl.rivm.nca.util.NumberUtil;

/**
 *
 */
public final class QueryUtil {
  public interface ValueFactory<O, T> {
    T getValue(O obj);
  }

  private QueryUtil() {
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static int getInt(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getInt(att.attribute());
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static long getLong(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getLong(att.attribute());
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static double getDouble(final ResultSet rs, final Attribute att) throws SQLException {
    return NumberUtil.safeFloat2Double(rs.getFloat(att.attribute()));
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static float getFloat(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getFloat(att.attribute());
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static String getString(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getString(att.attribute());
  }

  public static <E extends Enum<E>> E getEnum(final ResultSet rs, final Attribute att, final Class<E> enumClass) throws SQLException {
    return EnumUtil.get(enumClass, getString(rs, att));
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static Date getDate(final ResultSet rs, final Attribute att) throws SQLException {
    final Timestamp timestamp = rs.getTimestamp(att.attribute());
    return timestamp == null ? null : new Date(timestamp.getTime());
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static boolean getBoolean(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getBoolean(att.attribute());
  }

  /**
   * @param rs The resultset to get the value from.
   * @param att The attribute to get the value for.
   * @return The value corresponding to this enum in the resultset.
   * @throws SQLException In case of a query error.
   */
  public static Object getObject(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getObject(att.attribute());
  }

  /**
   * @param rs The resultset containing the binary.
   * @param att The attribute that has the bytes.
   * @return The bytes as byte array.
   * @throws SQLException In case of a query error.
   */
  public static byte[] getBinary(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getBytes(att.attribute());
  }

  /**
   * Checks whether an attribute is empty (SQL NULL).
   * @param rs The resultset to do the null check in.
   * @param att The attribute to check for.
   * @return Whether the field is empty (SQL NULL).
   * @throws SQLException In case of a query error.
   */
  public static boolean isNull(final ResultSet rs, final Attribute att) throws SQLException {
    return rs.getObject(att.attribute()) == null;
  }

  /**
   * Sets the objects as value on the prepared statement in the order of the list.
   * @param stmt prepared statement
   * @param objects objects to set
   * @throws SQLException on sql error
   */
  public static void setValues(final PreparedStatement stmt, final Object... objects) throws SQLException {
    for (int i = 0; i < objects.length; i++) {
      stmt.setObject(i + 1, objects[i]);
    }
  }

  /**
   * @param connection The connection to use when creating the array.
   * @param enumValues The set of enum values to use in the array.
   * @param <T> The enum type.
   * @return The SQL Array containing the values.
   * @throws SQLException In case of some databae error.
   */
  public static <T extends Enum<?>> Array toSQLArray(final Connection connection, final Set<T> enumValues) throws SQLException {
    final Set<String> enumValueNames = new HashSet<>();

    for (final T enumValue : enumValues) {
      enumValueNames.add(enumValue.name().toLowerCase());
    }

    return connection.createArrayOf("text", enumValueNames.toArray(new String[enumValueNames.size()]));
  }

  /**
   * @param connection The connection to use when creating the array.
   * @param values The values to use in the array.
   * @param <T> The value type.
   * @return The SQL Array containing the values.
   * @throws SQLException In case of some databae error.
   */
  public static <T extends Number> Array toNumericSQLArray(final Connection connection, final Collection<T> values) throws SQLException {
    return connection.createArrayOf("numeric", values.toArray(new Number[values.size()]));
  }

  /**
   * @param connection The connection to use when creating the array.
   * @param values The values to use in the array.
   * @param <T> The value type.
   * @return The SQL Array containing the values.
   * @throws SQLException In case of some databae error.
   */
  public static <T extends Number, O> Array toNumericSQLArray(final Connection connection, final Collection<O> values,
      final ValueFactory<O, T> factory) throws SQLException {
    final Set<T> reducedValues = new HashSet<>();

    for (final O value : values) {
      reducedValues.add(factory.getValue(value));
    }

    return toNumericSQLArray(connection, reducedValues);
  }
}
