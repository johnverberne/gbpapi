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

import java.text.MessageFormat;

/**
 * Simple order by clause for a query.
 */
public class OrderByClause {

  private static final String SELECT_PATTERN = "{0} {1}";

  private final Attribute attribute;
  private final OrderType orderType;

  /**
   * The type of ordering to use.
   */
  public enum OrderType {
    /**
     * An ascending ordering.
     */
    ASC,
    /**
     * A descending ordering.
     */
    DESC
  }

  /**
   * @param attribute The attribute to order by.
   */
  public OrderByClause(final Attribute attribute) {
    this(attribute, OrderType.ASC);
  }

  /**
   * @param attribute The attribute to order by.
   * @param orderType The type of ordering to use.
   */
  public OrderByClause(final Attribute attribute, final OrderType orderType) {
    this.attribute = attribute;
    this.orderType = orderType;
  }

  protected String toOrderByPart() {
    return MessageFormat.format(SELECT_PATTERN, attribute.attribute(), orderType.name());
  }

}
