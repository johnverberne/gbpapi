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
 * Where clause based on an Attribute. Will be used in the form "attribute = ?"
 */
public class BooleanWhereClause implements WhereClause {

  private static final String WHERE_PATTERN = "{0} IS {1}";

  private final Attribute attribute;
  private final boolean value;

  public BooleanWhereClause(final Attribute attribute, final boolean value) {
    this.attribute = attribute;
    this.value = value;
  }

  @Override
  public String toWherePart() {
    return MessageFormat.format(WHERE_PATTERN, attribute.attribute(), Boolean.toString(value).toUpperCase());
  }

  @Override
  public Attribute[] getParamAttributes() {
    return new Attribute[0];
  }

}
