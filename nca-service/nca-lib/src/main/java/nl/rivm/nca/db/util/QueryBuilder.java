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
 * Query construction helper.
 * <br><br>
 * Most methods can be called multiple times if needed.
 * In such a case, the new parameters will be added behind the previous calls.
 * <br>
 * Example of use:
 * <br><br>
 * <code>
 * private static final String IMPORTANT_QUERY =
 * <br>QueryBuilder.from("some_important_view")
 * <br>    .select(SomeAttribute.ID_ATTRIBUTE, SomeAttribute.SOME_VALUE_ATTRIBUTE)
 * <br>    .where(QueryAttribute.YEAR)
 * <br>    .orderBy(SomeAttribute.SOME_VALUE_ATTRIBUTE).getQuery();
 * </code>
 * <br><br>
 * Makes it easier to construct simple queries. Should be used in combination with {@link Attribute} interface.
 */
public final class QueryBuilder {

  private final List<SelectClause> selects = new ArrayList<>();

  private final List<JoinClause> joins = new ArrayList<>();

  private final List<WhereClause> filters = new ArrayList<>();

  private final List<Attribute> groupings = new ArrayList<>();
  private final List<OrderByClause> orderings = new ArrayList<>();

  private int limit = -1;
  private boolean offset;

  private boolean distinct;

  private final String fromString;
  private final Attribute[] paramAttributes;

  private QueryBuilder(final String from, final Attribute... paramAttributes) {
    fromString = from;
    this.paramAttributes = paramAttributes;
  }

  /**
   * Method to start building a query.
   * @param from The table or view to select from.
   * @param paramAttributes In case the from part uses ?, like a function, these attributes can be used to set these params using Query.
   * @return The querybuilder to continue working with.
   */
  public static QueryBuilder from(final String from, final Attribute... paramAttributes) {
    return new QueryBuilder(from, paramAttributes);
  }

  /**
   * Add attributes to select to the query. Can be called multiple times to add more, not replace.
   * @param select The attribute(s) to select in this query.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder select(final Attribute... select) {
    for (final Attribute attribute : select) {
      selects.add(new SelectClause(attribute));
    }
    return this;
  }

  /**
   * Add attributes to select to the query. Can be called multiple times to add more, not replace.
   * @param select The attributes to select in this query.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder select(final Attributes select) {
    return select(select.get());
  }

  /**
   * Add SelectClauses for the query.
   * @param select The attribute(s) to select in this query.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder select(final SelectClause... select) {
    selects.addAll(Arrays.asList(select));
    return this;
  }

  /**
   * Add joins to the query. These are used in the order they are added.
   * @param join The join(s) to use for this query.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder join(final JoinClause... join) {
    joins.addAll(Arrays.asList(join));
    return this;
  }

  /**
   * @param attributes The attribute(s) to filter the query on.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder where(final Attribute... attributes) {
    for (final Attribute attribute : attributes) {
      filters.add(new DefaultWhereClause(attribute));
    }
    return this;
  }

  /**
   * @param whereClauses The where clause(s) to filter the query on.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder where(final WhereClause... whereClauses) {
    filters.addAll(Arrays.asList(whereClauses));
    return this;
  }

  /**
   * @param attributes The attribute(s) to group the result by.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder groupBy(final Attribute... attributes) {
    groupings.addAll(Arrays.asList(attributes));
    return this;
  }

  /**
   * @param attributes The attribute(s) to order the result by.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder orderBy(final Attribute... attributes) {
    for (final Attribute attribute : attributes) {
      orderings.add(new OrderByClause(attribute));
    }
    return this;
  }

  /**
   * @param orderByClauses The OrderByClauses to order the result by.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder orderBy(final OrderByClause... orderByClauses) {
    orderings.addAll(Arrays.asList(orderByClauses));
    return this;
  }

  /**
   * Use a limit for the query.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder limit() {
    limit = 0;
    return this;
  }

  public QueryBuilder limit(final int limit) {
    this.limit = limit;
    return this;
  }

  /**
   * Use an offset for the query (only works if limit is used as well).
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder offset() {
    offset = true;
    return this;
  }

  /**
   * Use a distinct for the query.
   * @return This querybuilder to chain methods.
   */
  public QueryBuilder distinct() {
    distinct = true;
    return this;
  }

  /**
   * @return The query that fits the previously called methods.
   */
  public Query getQuery() {
    final List<Attribute> attributes = new ArrayList<>();
    final StringBuilder builder = new StringBuilder();

    addSelect(builder, attributes);
    addFrom(builder, attributes);
    addWhere(builder, attributes);
    addGroupingAndOrdering(builder, attributes);

    return new Query(builder.toString(), attributes);
  }

  private void addSelect(final StringBuilder builder, final List<Attribute> attributes) {
    builder.append("SELECT ");
    if (distinct) {
      builder.append("DISTINCT ");
    }
    if (selects.isEmpty()) {
      builder.append('*');
    } else {
      final List<String> formattedSelects = new ArrayList<>();
      for (final SelectClause clause : selects) {
        formattedSelects.add(clause.toSelectPart());
        attributes.addAll(Arrays.asList(clause.getParamAttributes()));
      }
      builder.append(StringUtils.join(formattedSelects, ", "));
    }
  }

  private void addFrom(final StringBuilder builder, final List<Attribute> attributes) {
    builder.append(" FROM ");
    builder.append(fromString);
    attributes.addAll(Arrays.asList(paramAttributes));
    for (final JoinClause clause : joins) {
      builder.append(clause.toJoinPart());
      attributes.addAll(Arrays.asList(clause.getParamAttributes()));
    }
  }

  private void addGroupingAndOrdering(final StringBuilder builder, final List<Attribute> attributes) {
    if (!groupings.isEmpty()) {
      final List<String> formattedGroupings = new ArrayList<>();
      for (final Attribute grouping : groupings) {
        formattedGroupings.add(grouping.attribute());
      }
      builder.append(" GROUP BY ");
      builder.append(StringUtils.join(formattedGroupings, ", "));
    }
    if (!orderings.isEmpty()) {
      final List<String> formattedOrderings = new ArrayList<>();
      for (final OrderByClause ordering : orderings) {
        formattedOrderings.add(ordering.toOrderByPart());
      }
      builder.append(" ORDER BY ");
      builder.append(StringUtils.join(formattedOrderings, ", "));
    }
    if (limit == 0) {
      builder.append(" LIMIT ?");
      attributes.add(SpecialAttribute.LIMIT);
    } else if (limit > 0) {
      builder.append(" LIMIT ");
      builder.append(limit);
    }
    if (limit >= 0 && offset) {
      builder.append(" OFFSET ?");
      attributes.add(SpecialAttribute.OFFSET);
    }
  }

  private void addWhere(final StringBuilder builder, final List<Attribute> attributes) {
    if (!filters.isEmpty()) {
      builder.append(" WHERE ");
      final List<String> formattedFilters = new ArrayList<>();
      for (final WhereClause filter : filters) {
        formattedFilters.add(filter.toWherePart());
        attributes.addAll(Arrays.asList(filter.getParamAttributes()));
      }
      builder.append(StringUtils.join(formattedFilters, " AND "));
    }

  }

}
