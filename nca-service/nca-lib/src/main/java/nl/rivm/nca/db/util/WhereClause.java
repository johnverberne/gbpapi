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
 * Where clause or filter part of a query.
 */
public interface WhereClause {

  /**
   * @return The part to use in the actual query.
   */
  String toWherePart();

  /**
   * @return The attributes that can be used to set parameters on the prepared statement.
   * Should correspond to each ? in the String returned by {@link #toWherePart()}.
   */
  Attribute[] getParamAttributes();

}
