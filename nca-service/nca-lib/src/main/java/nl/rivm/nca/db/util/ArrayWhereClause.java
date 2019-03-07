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
 * Where clause or filter part of the query based on collections.
 * Will appear in the query in the from "attribute = ANY (?)".
 */
public class ArrayWhereClause implements WhereClause {

  private static final String WHERE_ARRAY_PATTERN = " {0} = ANY (?) ";

  private final Attribute attribute;

  /**
   * @param attribute The attribute to filter the query on, and are collections.
   */
  public ArrayWhereClause(final Attribute attribute) {
    this.attribute = attribute;
  }

  @Override
  public String toWherePart() {
    return MessageFormat.format(WHERE_ARRAY_PATTERN, attribute.attribute());
  }

  @Override
  public Attribute[] getParamAttributes() {
    return new Attribute[] { attribute };
  }

}
