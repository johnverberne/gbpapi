/*
 * Copyright the State of the Netherlands
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
package nl.rivm.nca.db;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Persistence Manager Factory manages the database connection.
 */
public interface PMF {

  /**
   * Postgresql error code when unique key violation is thrown.
   */
  String UNIQUE_VIOLATION = "23505";

  /**
   * Get a connection usable for database queries in AERIUS.
   * @return A connection to use, ensure to use it within a try-with-resources block.
   * @throws SQLException When no connection could be made with the database.
   */
  Connection getConnection() throws SQLException;

  /**
   * Returns the version of the data set as set in the database.
   * @return version of data in database
   * @throws SQLException database error
   */
  String getDatabaseVersion() throws SQLException;
}
