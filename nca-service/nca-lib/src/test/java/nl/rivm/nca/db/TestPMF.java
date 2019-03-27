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
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp.DelegatingConnection;
import org.postgresql.PGConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * PMF implementation for using within tests. Has the option to cache the
 * connection.
 */
public class TestPMF {

	private static final Logger LOGGER = LoggerFactory.getLogger(TestPMF.class);

	private boolean firstTime = true;
	private String jdbcURL;
	private String dbUsername;
	private String dbPassword;
	private ProductType productType;
	private boolean autoCommit;
	private final boolean cacheConnection;
	private final List<DelegatingConnectionExtension> connections = new ArrayList<>();

	public TestPMF(final boolean cacheConnection) {
		this.cacheConnection = cacheConnection;
	}

	/**
	 * Closes the connection for real. The connection's own close is hijacked to
	 * avoid in between closes in try blocks.
	 *
	 * @throws SQLException
	 */
	public void close() throws SQLException {
		for (final DelegatingConnectionExtension con : connections) {
			try {
				if (con == null) {
					LOGGER.warn("trying to close a null connection.");
				} else {
					con.reallyClose();
					if (!con.isClosed()) {
						con.reallyClose();
					}
				}
			} catch (final SQLException e) {
				// Ingore
			}
		}
		connections.clear();
	}

	/**
	 * Returns a new connection to the AeriusDB database.
	 *
	 * @return a database connection
	 * @throws SQLException
	 */
	public Connection getConnection() throws SQLException {
		if (firstTime) {
			firstTime = false; // reset init field before call in case init
								// method decides to call getConnection.
			// DBMessages.init(this);
		}

		final Connection connection;
		if (autoCommit) {
			connection = getAutoCommitedConnection();
		} else {
			connection = getNonAutoCommitedConnection();
		}
		return connection;
	}

	private Connection getAutoCommitedConnection() throws SQLException {
		final DelegatingConnectionExtension connection = createConnection();
		connections.add(connection);
		return connection;
	}

	private Connection getNonAutoCommitedConnection() throws SQLException {
		final Connection connection;
		if (!cacheConnection) {
			close();
		}
		if (connections.isEmpty()) {
			connections.add(createConnection());
		}
		connection = connections.get(0);
		return connection;
	}

	private DelegatingConnectionExtension createConnection() throws SQLException {
		final Connection actualConnection = DriverManager.getConnection(jdbcURL, dbUsername, dbPassword);
		((PGConnection) actualConnection).addDataType("geometry", org.postgis.PGgeometry.class);
		actualConnection.setAutoCommit(autoCommit);
		return new DelegatingConnectionExtension(actualConnection);
	}

	public void setJdbcURL(final String jdbcURL) {
		this.jdbcURL = jdbcURL;
	}

	public void setDbUsername(final String dbUsername) {
		this.dbUsername = dbUsername;
	}

	public void setDbPassword(final String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public void setAutoCommit(final boolean autoCommit) {
		this.autoCommit = autoCommit;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;

	}

	@Override
	public String toString() {
		return "TestPMF [jdbcURL=" + jdbcURL + ", autoCommit=" + autoCommit + ", cacheConnection=" + cacheConnection
				+ "]";
	}

	/**
	 * Wraps the connection class to hijack the close call, to avoid autoclosing
	 * the connection in try blocks.
	 */
	private final class DelegatingConnectionExtension extends DelegatingConnection {
		/**
		 * @param c
		 */
		private DelegatingConnectionExtension(final Connection c) {
			super(c);
		}

		@Override
		public void close() throws SQLException {
			// don't close when autocommit is false
			if (autoCommit) {
				super.close();
			}
		}

		/**
		 * Close the connection.
		 *
		 * @throws SQLException
		 */
		public void reallyClose() throws SQLException {
			super.close();
		}
	}

}
