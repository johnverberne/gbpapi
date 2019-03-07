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
package nl.rivm.nca.db.user;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import org.junit.Test;

import nl.rivm.nca.db.TestPMF;
import nl.rivm.nca.exception.AeriusException;
import nl.rivm.nca.shared.domain.JobProgress;
import nl.rivm.nca.shared.domain.ScenarioUser;

public class JobRepositoryTest {

	private static final String TEST_API_KEY = "0000-0000-0000-0000";

	@Test
	public void testGetCalculationsProgressForUser() throws SQLException {
		List<JobProgress> progresses;
		ScenarioUser user = UserRepository.getUserByApiKey(getConnection(), TEST_API_KEY);
		assertNotNull("user found ", user);

		progresses = JobRepository.getProgressForUser(getConnection(), user);
		assertEquals("Jobs count ", 1, progresses.size());
	}

	@Test
	public void testCreateUser() throws SQLException, AeriusException {
		String apiKey = UUID.randomUUID().toString();
		ScenarioUser user = new ScenarioUser();
		user.setApiKey(apiKey);
		user.setEnabled(true);
		user.setEmailAddress("johnverberne."+apiKey+"@gmail.com");
		UserRepository.createUser(getConnection(), user);
		ScenarioUser existingUser = UserRepository.getUserByApiKey(getConnection(), apiKey);
		assertNotNull("user found ", existingUser);
	}

	protected Connection getConnection() throws SQLException {
		TestPMF pmf = new TestPMF(true);
		pmf.setJdbcURL("jdbc:postgresql://localhost/unittest_NCA-gbp");
		pmf.setDbUsername("aerius");
		pmf.setDbPassword("hallo2dirk337");
		return pmf.getConnection();
	}

}
