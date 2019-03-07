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

import java.util.Arrays;


/**
 * Can be used to filter for a set value (like "foo IS NULL" or "bar = 'bar_type'").
 * Can also be used to filter with a different operator (like "foo < ?" or "bar between ? and ?")
 */
public class StaticWhereClause implements WhereClause {

  private final String wherePart;
  private final Attribute[] paramAttributes;

  /**
   * @param wherePart The string that is where, like "bar between ? and ?"
   * @param paramAttributes The attributes corresponding to the ?'s, like Attribute.MIN_VALUE and Attribute.MAX_VALUE.
   */
  public StaticWhereClause(final String wherePart, final Attribute... paramAttributes) {
    this.wherePart = wherePart;
    this.paramAttributes = paramAttributes;
  }

  @Override
  public String toWherePart() {
    return wherePart;
  }

  @Override
  public Attribute[] getParamAttributes() {
    return Arrays.copyOf(paramAttributes, paramAttributes.length);
  }

}
