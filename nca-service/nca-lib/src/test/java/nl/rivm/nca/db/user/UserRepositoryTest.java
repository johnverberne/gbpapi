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

import nl.rivm.nca.db.BaseDBTest;
import nl.rivm.nca.db.TestPMF;
import nl.rivm.nca.shared.domain.JobProgress;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;

public class UserRepositoryTest extends BaseDBTest {

	private static final String TEST_API_KEY = "0000-0000-0000-0000";

	@Test
	public void testCreateUser() throws SQLException, AeriusException {
		String apiKey = UUID.randomUUID().toString();
		ScenarioUser user = new ScenarioUser();
		user.setApiKey(apiKey);
		user.setEnabled(true);
		user.setEmailAddress("johnverberne." + apiKey + "@gmail.com");
		UserRepository.createUser(getGbpConnection(), user);
		ScenarioUser existingUser = UserRepository.getUserByApiKey(getGbpConnection(), apiKey);
		assertNotNull("user found ", existingUser);
	}
}
