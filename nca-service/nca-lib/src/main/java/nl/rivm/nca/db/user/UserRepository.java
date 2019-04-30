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
package nl.rivm.nca.db.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.postgresql.util.PSQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.db.PMF;
import nl.rivm.nca.db.util.Attribute;
import nl.rivm.nca.db.util.Attributes;
import nl.rivm.nca.db.util.InsertBuilder;
import nl.rivm.nca.db.util.Query;
import nl.rivm.nca.db.util.QueryAttribute;
import nl.rivm.nca.db.util.QueryBuilder;
import nl.rivm.nca.db.util.QueryUtil;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

public final class UserRepository {

	private enum RepositoryAttribute implements Attribute {
		API_KEY, EMAIL_ADDRESS, MAX_CONCURRENT_JOBS, ENABLED, REQUEST_REFERENCE;

		@Override
		public String attribute() {
			return name().toLowerCase();
		}
	}

	private static final Logger LOG = LoggerFactory.getLogger(UserRepository.class);

	private static final String TABLE_USERS = "users";

	private static final Attributes FIELDS_USERS = new Attributes(RepositoryAttribute.API_KEY,
			RepositoryAttribute.EMAIL_ADDRESS, RepositoryAttribute.ENABLED, RepositoryAttribute.MAX_CONCURRENT_JOBS);

	private static final Query QUERY_CREATE_USER = InsertBuilder.into(TABLE_USERS).insert(FIELDS_USERS).getQuery();
	private static final String UPDATE_USER_API_KEY = "UPDATE users SET " + RepositoryAttribute.API_KEY
			+ " = ? WHERE user_id = ?";
	private static final Query QUERY_GET_USER_BY_API_KEY = getUsersQueryBuilder().where(RepositoryAttribute.API_KEY)
			.getQuery();
	private static final Query QUERY_GET_USER_BY_EMAIL_ADDRESS = getUsersQueryBuilder()
			.where(RepositoryAttribute.EMAIL_ADDRESS).getQuery();

	private UserRepository() {
		// Not allowed to instantiate.
	}

	/**
	 * Creates a Scenario user. The ScenarioUser object's id will be updated.
	 *
	 * @param con
	 *            The connection to use.
	 * @param user
	 *            The user to create (id is ignored / max concurrent jobs is
	 *            automatically filled).
	 * @throws SQLException
	 *             In case of a database error.
	 * @throws AeriusException
	 *             When the user already exists.
	 */
	public static void createUser(final Connection con, final ScenarioUser user) throws SQLException, AeriusException {
		// validateUserNotExists(con, user);

		try (final PreparedStatement ps = con.prepareStatement(QUERY_CREATE_USER.get(),
				Statement.RETURN_GENERATED_KEYS)) {
			QUERY_CREATE_USER.setParameter(ps, RepositoryAttribute.API_KEY, user.getApiKey());
			QUERY_CREATE_USER.setParameter(ps, RepositoryAttribute.EMAIL_ADDRESS, user.getEmailAddress().toLowerCase());
			QUERY_CREATE_USER.setParameter(ps, RepositoryAttribute.ENABLED, user.isEnabled());
			QUERY_CREATE_USER.setParameter(ps, RepositoryAttribute.MAX_CONCURRENT_JOBS, 9); 

			ps.executeUpdate();
			final ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				user.setId(rs.getInt(1));
			} else {
				throw new AeriusException(Reason.INTERNAL_ERROR, user.getEmailAddress());
			}
		} catch (final PSQLException e) {

			if (PMF.UNIQUE_VIOLATION.equals(e.getSQLState())) {
				LOG.error("Error creating user for {}", user.getEmailAddress(), e);
				throw new AeriusException(Reason.USER_ALREADY_EXISTS, user.getEmailAddress());
			} else {
				throw e;
			}
		}
	}

	/**
	 * Fetch a Scenario user from the database using the api key for lookup.
	 * Returns null when the user is not found.
	 */
	public static ScenarioUser getUserByApiKey(final Connection con, final String apiKey) throws SQLException {
		ScenarioUser user = null;
		try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_USER_BY_API_KEY.get())) {
			QUERY_GET_USER_BY_API_KEY.setParameter(stmt, RepositoryAttribute.API_KEY, apiKey);
			final ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				user = new ScenarioUser();
				fillUser(user, rs);
			}
		}
		return user;
	}

	public static void updateUser(final Connection con, final ScenarioUser user) throws SQLException {
		try (final PreparedStatement ps = con.prepareStatement(UPDATE_USER_API_KEY)) {
			int parameterIdx = 1;
			// update part
			ps.setString(parameterIdx++, user.getApiKey());
			ps.setInt(parameterIdx++, user.getId());
			ps.executeUpdate();
		}
	}

	/**
	 * Fetch a Scenario user from the database using the email address for
	 * lookup. Returns null when the user is not found.
	 */
	public static ScenarioUser getUserByEmailAddress(final Connection con, final String email) throws SQLException {
		nl.rivm.nca.shared.domain.user.ScenarioUser user = null;
		try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_USER_BY_EMAIL_ADDRESS.get())) {
			QUERY_GET_USER_BY_EMAIL_ADDRESS.setParameter(stmt, RepositoryAttribute.EMAIL_ADDRESS, email.toLowerCase());
			final ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				user = new ScenarioUser();
				fillUser(user, rs);
			}
		}
		return user;
	}

	
	private static void validateUserNotExists(final Connection con, final ScenarioUser user)
			throws AeriusException, SQLException {
		if (getUserByEmailAddress(con, user.getEmailAddress()) != null) {
			throw new AeriusException(Reason.USER_EMAIL_ADDRESS_ALREADY_EXISTS, user.getEmailAddress());
		}
		if (getUserByApiKey(con, user.getApiKey()) != null) {
			throw new AeriusException(Reason.USER_API_KEY_ALREADY_EXISTS);
		}
	}
	

	private static void fillUser(final ScenarioUser user, final ResultSet rs) throws SQLException {
		user.setId(QueryAttribute.USER_ID.getInt(rs));
		user.setApiKey(QueryUtil.getString(rs, RepositoryAttribute.API_KEY));
		user.setEmailAddress(QueryUtil.getString(rs, RepositoryAttribute.EMAIL_ADDRESS));
		user.setEnabled(QueryUtil.getBoolean(rs, RepositoryAttribute.ENABLED));
		user.setMaxConcurrentJobs(QueryUtil.getInt(rs, RepositoryAttribute.MAX_CONCURRENT_JOBS));
	}

	private static QueryBuilder getUsersQueryBuilder() {
		return QueryBuilder.from(TABLE_USERS).select(QueryAttribute.USER_ID).select(FIELDS_USERS);
	}

}
