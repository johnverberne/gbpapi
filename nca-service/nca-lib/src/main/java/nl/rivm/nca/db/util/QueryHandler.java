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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Abstract basic class to handle queries. Handles creating the prepared statement, executing the actual query and looping through the result.
 * Depending on implementation, this isn't threadsafe...
 */
public abstract class QueryHandler {

  /**
   * @param con The connection to use to execute the query.
   * @param query The query to execute.
   * @throws SQLException In case of execution errors.
   */
  public void execute(final Connection con, final Query query) throws SQLException {
    try (final PreparedStatement ps = con.prepareStatement(query.get())) {
      setParameters(ps, query);

      final ResultSet rs = ps.executeQuery();
      while (rs.next()) {
        handleResult(rs);
      }
    }
  }

  /**
   * Use to set the parameters for a query supplied to execute.
   */
  protected abstract void setParameters(PreparedStatement ps, Query query) throws SQLException;

  /**
   * Handle a resultset (1 row resulting from the query). Will be called multiple times if there are more results.
   * Not keeping track of results in the base handler, so better do something with them in the implementation of this function.
   */
  protected abstract void handleResult(ResultSet rs) throws SQLException;

}
