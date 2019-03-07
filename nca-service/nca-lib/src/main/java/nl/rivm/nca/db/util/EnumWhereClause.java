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
 * Can be used to filter for a set enum value (like "bar = 'bar_type'").
 * No need for parameters in this case, the value of the enum is used in the query as is (the lower case version of the declaration).
 */
public class EnumWhereClause<E extends Enum<E>> implements WhereClause {

  private static final String WHERE_ENUM_PATTERN = "{0} = ''{1}''";

  private final Attribute attribute;
  private final E value;

  /**
   * @param attribute The attribute to use for this where clause.
   * @param value The value of the enum.
   */
  public EnumWhereClause(final Attribute attribute, final E value) {
    this.attribute = attribute;
    this.value = value;
  }

  @Override
  public String toWherePart() {
    return MessageFormat.format(WHERE_ENUM_PATTERN, attribute.attribute(), value.name().toLowerCase());
  }

  @Override
  public Attribute[] getParamAttributes() {
    return new Attribute[0];
  }

}
