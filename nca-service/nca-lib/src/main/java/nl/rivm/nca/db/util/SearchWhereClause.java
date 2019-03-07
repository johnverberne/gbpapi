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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

/**
 * Where clause or filter part where attributes have to be searched.
 * Will appear in the query in the from "attribute ILIKE ?".
 * Multiple attributes will be added in the form "attribute1 ILIKE ? OR attribute2 ILIKE 2 OR...".
 */
public class SearchWhereClause implements WhereClause {

  private static final String WHERE_SEARCH_PATTERN = " {0} ILIKE ? ";
  private static final String MULTIPLE_SEARCH_SEPARATOR = "OR";

  private final Attribute[] attributes;

  /**
   * @param attributes The attributes to filter the query on, and are collections.
   */
  public SearchWhereClause(final Attribute... attributes) {
    this.attributes = attributes;
  }

  @Override
  public String toWherePart() {
    final List<String> searchParts = new ArrayList<>();
    for (final Attribute attribute : attributes) {
      searchParts.add(MessageFormat.format(WHERE_SEARCH_PATTERN, attribute.attribute()));
    }
    return StringUtils.join(searchParts, MULTIPLE_SEARCH_SEPARATOR);
  }

  @Override
  public Attribute[] getParamAttributes() {
    return Arrays.copyOf(attributes, attributes.length);
  }

}
