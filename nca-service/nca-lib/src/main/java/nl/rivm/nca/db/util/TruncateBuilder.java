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
 * TRUNCATE query construction helper.
 * <br><br>
 * This a very simple utility class because it only takes the table name.
 */
public final class TruncateBuilder {

  private static final String TRUNCATE_STATEMENT = "TRUNCATE TABLE ";

  private final String table;

  private TruncateBuilder(final String table) {
    this.table = table;
  }

  /**
   * Method to start building a truncate query.
   * @param from The table to truncate.
   * @return The TruncateBuilder to continue working with.
   */
  public static TruncateBuilder truncate(final String table) {
    return new TruncateBuilder(table);
  }

  /**
   * @return The query that fits the previously called methods.
   */
  public Query getQuery() {
    final StringBuilder builder = new StringBuilder();
    builder.append(TRUNCATE_STATEMENT);
    builder.append(table);
    return new Query(builder.toString(), null);
  }

}
