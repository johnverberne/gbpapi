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
 * Where clause or filter part of the query based on search strings.
 * Will appear in the query in the from "attribute ilike ?".
 * Be sure to use the static getSearchString method in this class.
 */
public class ILikeWhereClause implements WhereClause {

  private static final String WHERE_ILIKE_PATTERN = " {0} ilike ? ";
  private static final String SEARCH_WILDCARD_PATTERN = "%{0}%";

  private static final String WILDCARD_ALL = "%";
  private static final String WILDCARD_SINGLE = "_";
  private static final String WILDCARD_ESCAPE = "\\";

  private final Attribute attribute;

  /**
   * @param attribute The attribute to filter the query on, and is a search string.
   */
  public ILikeWhereClause(final Attribute attribute) {
    this.attribute = attribute;
  }

  @Override
  public String toWherePart() {
    return MessageFormat.format(WHERE_ILIKE_PATTERN, attribute.attribute());
  }

  @Override
  public Attribute[] getParamAttributes() {
    return new Attribute[] { attribute };
  }

  public static String getSearchString(final String searchString) {
    return MessageFormat.format(SEARCH_WILDCARD_PATTERN, searchString
        .replace(WILDCARD_ALL, WILDCARD_ESCAPE + WILDCARD_ALL)
        .replace(WILDCARD_SINGLE, WILDCARD_ESCAPE + WILDCARD_SINGLE));
  }
}
