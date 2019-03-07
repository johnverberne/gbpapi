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

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 */
public class Query {

  private static final Logger LOG = LoggerFactory.getLogger(Query.class);

  private final String queryString;
  private final List<Attribute> attributes;

  /**
   * @param queryString The string for this query (should be a proper SQL statement).
   * @param attributes The list of attributes used in the query, ordered as they would appear in the query.
   */
  protected Query(final String queryString, final List<Attribute> attributes) {
    this.queryString = queryString;
    this.attributes = attributes;
  }

  public String get() {
    return queryString;
  }

  public void setParameter(final PreparedStatement stmt, final Attribute attribute, final Object value) throws SQLException {
    if (attributes.contains(attribute)) {
      stmt.setObject(getParameterIndexOf(attribute), value);
    } else {
      LOG.debug("Could not find attribute {} to set value {} for Query {}", attribute, value, stmt);
    }
  }

  public void setParameter(final PreparedStatement stmt, final Attribute attribute, final Object value, final int targetSQLType) throws SQLException {
    if (attributes.contains(attribute)) {
      stmt.setObject(getParameterIndexOf(attribute), value, targetSQLType);
    } else {
      LOG.debug("Could not find attribute {} to set value {} for Query {} with Types ID {}", attribute, value, stmt, targetSQLType);
    }
  }

  public boolean hasParameter(final Attribute attribute) {
    return attributes.contains(attribute);
  }

  public int getParameterIndexOf(final Attribute attribute) {
    return attributes.indexOf(attribute) + 1;
  }

  /**
   * Transforms this Query object into a new one which returns the record count of the query
   * (using the countAttribute field). The new Query object is returned. It uses the same
   * attributes as the original one.
   * @param countAttribute Attribute to use for the COUNT(*) field.
   * @return New Query object
   */
  public Query toRecordCountQuery(final Attribute countAttribute) {
    final int rnd = Math.abs((new Random()).nextInt());
    final StringBuilder builder = new StringBuilder();
    builder.append("SELECT COUNT(*) AS ");
    builder.append(countAttribute.attribute().toLowerCase());
    builder.append(" FROM (");
    builder.append(queryString);
    builder.append(") AS ");
    builder.append("\"counter_" + Integer.toString(rnd) + "\"");
    return new Query(builder.toString(), attributes);
  }

}
