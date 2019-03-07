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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

/**
 * Insert query construction helper.
 * <br><br>
 * Most methods can be called multiple times if needed.
 * In such a case, the new parameters will be added behind the previous calls.
 * <br>
 * Example of use:
 * <br><br>
 * <code>
 * private static final String INSERT_QUERY =
 * <br>InsertBuilder.into("some_table")
 * <br>    .values(SomeAttribute.ID_ATTRIBUTE, SomeAttribute.SOME_VALUE_ATTRIBUTE)
 * <br>    .values(new InsertClause("geometry", "ST_SetSRID(ST_POINT(?, ?), ?)", QueryAttribute.X_COORD, QueryAttribute.Y_COORD, QueryAttribute.SRID))
 * <br>    .getQuery();
 * </code>
 * <br><br>
 * Makes it easier to construct simple queries. Should be used in combination with {@link Attribute} interface.
 */
public final class InsertBuilder {

  private static final String VALUE_SEPARATOR = ", ";

  private final List<InsertClause> inserts = new ArrayList<>();

  private final String table;

  private InsertBuilder(final String table) {
    this.table = table;
  }

  /**
   * Method to start building a insert query.
   * @param from The table to insert into.
   * @return The InsertBuilder to continue working with.
   */
  public static InsertBuilder into(final String table) {
    return new InsertBuilder(table);
  }

  /**
   * Add attributes to insert to the query. Can be called multiple times to add more, not replace.
   * @param insert The attribute(s) to insert in this query.
   * @return This querybuilder to chain methods.
   */
  public InsertBuilder insert(final Attribute... insert) {
    for (final Attribute attribute : insert) {
      inserts.add(new InsertClause(attribute.attribute(), attribute));
    }
    return this;
  }

  /**
   * Add attributes to insert to the query. Can be called multiple times to add more, not replace.
   * @param insert The attributes to insert in this query.
   * @return This querybuilder to chain methods.
   */
  public InsertBuilder insert(final Attributes insert) {
    return insert(insert.get());
  }

  /**
   * Add InsertClause for the query.
   * @param insert The attribute(s) to insert in this query.
   * @return This querybuilder to chain methods.
   */
  public InsertBuilder insert(final InsertClause... insert) {
    inserts.addAll(Arrays.asList(insert));
    return this;
  }

  /**
   * @return The query that fits the previously called methods.
   */
  public Query getQuery() {
    final List<Attribute> attributes = new ArrayList<>();
    final StringBuilder builder = new StringBuilder();

    addInsert(builder);
    addColumns(builder);
    addValues(builder, attributes);

    return new Query(builder.toString(), attributes);
  }

  private void addInsert(final StringBuilder builder) {
    builder.append("INSERT INTO ");
    builder.append(table);
  }

  private void addColumns(final StringBuilder builder) {
    builder.append('(');
    final List<String> columns = new ArrayList<>();
    for (final InsertClause insert : inserts) {
      columns.add(insert.getColumn());
    }
    builder.append(StringUtils.join(columns, VALUE_SEPARATOR));
    builder.append(')');
  }

  private void addValues(final StringBuilder builder, final List<Attribute> attributes) {
    builder.append(" VALUES (");
    final List<String> insertValues = new ArrayList<>();
    for (final InsertClause insert : inserts) {
      insertValues.add(insert.getInsertPart());
      attributes.addAll(Arrays.asList(insert.getParamAttributes()));
    }
    builder.append(StringUtils.join(insertValues, VALUE_SEPARATOR));
    builder.append(')');
  }

}
