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


/**
 * Insert clause for a insert query.
 */
public class InsertClause {

  private static final String DEFAULT_VALUE = "?";

  private final String tableColumn;
  private final String insertPart;
  private final Attribute[] paramAttributes;

  /**
   * @param tableColumn The attribute to select.
   */
  public InsertClause(final String tableColumn, final Attribute... paramAttributes) {
    this(tableColumn, DEFAULT_VALUE, paramAttributes);
  }

  /**
   * @param tableColumn The column to insert for.
   * @param insertPart The string to use as replacement for ? in the VALUES (?) part.
   */
  public InsertClause(final String tableColumn, final String insertPart, final Attribute... paramAttributes) {
    this.tableColumn = tableColumn;
    this.insertPart = insertPart;
    this.paramAttributes = paramAttributes;
  }

  protected String getColumn() {
    return tableColumn;
  }

  protected String getInsertPart() {
    return insertPart;
  }

  protected Attribute[] getParamAttributes() {
    return paramAttributes;
  }

}
