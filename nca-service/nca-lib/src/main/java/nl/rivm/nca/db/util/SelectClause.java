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
 * Simple join clause for a query.
 */
public class SelectClause {

  private static final String SELECT_NAME_PATTERN = "{0}.{1}";
  private static final String SELECT_PATTERN = " {0} AS {1} ";

  private final Attribute attribute;
  private final String as;
  private final Attribute[] paramAttributes;

  /**
   * @param attribute The attribute to select.
   */
  public SelectClause(final Attribute attribute, final Attribute... paramAttributes) {
    this(attribute, null, paramAttributes);
  }

  /**
   * @param attribute The attribute to select.
   * @param as The alias to recognize the attribute when retrieving results.
   */
  public SelectClause(final Attribute attribute, final String as, final Attribute... paramAttributes) {
    this.attribute = attribute;
    this.as = as;
    this.paramAttributes = paramAttributes;
  }

  /**
   * @param attribute The attribute to select.
   * @param as The alias to recognize the attribute when retrieving results.
   */
  public SelectClause(final String from, final String attribute, final String as, final Attribute... paramAttributes) {
    this(MessageFormat.format(SELECT_NAME_PATTERN, from, attribute), as, paramAttributes);
  }

  /**
   * @param attribute The attribute to select.
   * @param as The alias to recognize the attribute when retrieving results.
   */
  public SelectClause(final String attribute, final String as, final Attribute... paramAttributes) {
    this(new SimpleAttribute(attribute), as, paramAttributes);
  }

  protected String toSelectPart() {
    return as == null ? attribute.attribute() : MessageFormat.format(SELECT_PATTERN, attribute.attribute(), as);
  }

  protected Attribute[] getParamAttributes() {
    return paramAttributes;
  }

  private static class SimpleAttribute implements Attribute {

    private final String attribute;

    public SimpleAttribute(final String attribute) {
      this.attribute = attribute;
    }

    @Override
    public String attribute() {
      return attribute;
    }

  }

}
