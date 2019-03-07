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
 * Special query attribute enum.
 * These attributes have a special meaning (come in a different spot in the query), but a value can still be set for them.
 * Can be used in combination with {@link Query} to set the limit.
 */
public enum SpecialAttribute implements Attribute {

  /**
   * Amount of rows to limit to.
   */
  LIMIT,

  /**
   * The offset in the query
   */
  OFFSET;

  /**
   * @return the attribute representation as used in most queries.
   */
  @Override
  public String attribute() {
    return name().toLowerCase();
  }

}
