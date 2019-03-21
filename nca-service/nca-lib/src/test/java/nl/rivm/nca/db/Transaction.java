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
package nl.rivm.nca.db;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Savepoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Manager around a connection to simply deal with transactions.
 * See constructor for syntax.
 */
public class Transaction {

  private static final Logger LOG = LoggerFactory.getLogger(Transaction.class);

  private static boolean nested;

  protected final Connection connection;
  protected final boolean prevAutoCommit;
  protected Savepoint savePoint;
  protected boolean finished;

  /**
   * Start a transaction for a connection.
   *
   * <p><pre>
   * final Transaction transaction = new Transaction(connection);
   * try {
   *   // .. query stuff here ...
   * } catch (final SQLException e) {
   *   transaction.rollback();
   *   throw e;
   * } finally {
   *   transaction.commit();
   * }</pre></p>
   *
   * @param con
   * @throws SQLException
   */
  public Transaction(final Connection con) throws SQLException {
    connection = con;
    prevAutoCommit = connection.getAutoCommit();
    connection.setAutoCommit(false);
    finished = false;
    savePoint = nested ? con.setSavepoint() : null;
  }

  /**
   * Should only be set for unit tests: simulate a nested transaction using savepoints.
   * This is because unit tests already run in a kind of transaction (to keep the unit
   * test database in the same state always), so when someone then uses this class it
   * should be dealt with somehow as a nested transaction.
   */
  public static void setNested() {
    Transaction.nested = true;
  }

  /**
   * Rolls back this transaction and restores autocommit state.
   */
  public void rollback() {
    try {
      if (!finished) {
        if (nested) {
          connection.rollback(savePoint);
        } else {
          connection.rollback();
        }
        finished = true;
      }
      connection.setAutoCommit(prevAutoCommit);
    } catch (final SQLException e) {
      LOG.warn("SQLException while rolling back", e);
    }
  }

  /**
   * Commits this transaction (if not already rolled back) and restores autocommit state.
   */
  public void commit() throws SQLException {
    if (!finished) {
      if (!nested) {
        connection.commit();
      }
      finished = true;
    }
    connection.setAutoCommit(prevAutoCommit);
  }
}
