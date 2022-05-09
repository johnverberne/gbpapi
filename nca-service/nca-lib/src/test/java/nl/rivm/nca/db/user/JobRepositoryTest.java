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

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.junit.Test;

import nl.rivm.nca.db.BaseDBTest;
import nl.rivm.nca.db.calculation.CalculationRepository;
import nl.rivm.nca.shared.domain.JobProgress;
import nl.rivm.nca.shared.domain.JobType;
import nl.rivm.nca.shared.domain.calculation.Calculation;
import nl.rivm.nca.shared.domain.calculation.JobState;
import nl.rivm.nca.shared.domain.user.ScenarioUser;

public class JobRepositoryTest extends BaseDBTest {

	private static final String TEST_API_KEY = "0000-0000-0000-0000";

	@Test
	public void testCreateJob() throws SQLException {
		JobProgress progress = null;
		String correlationId = UUID.randomUUID().toString();
		ScenarioUser user = UserRepository.getUserByApiKey(getGbpConnection(), TEST_API_KEY);
		JobRepository.createJob(getGbpConnection(), user, JobType.CALCULATION, correlationId);

		progress = JobRepository.getProgress(getGbpConnection(), correlationId);
		assertEquals("Job must be initialized ", JobState.INITIALIZED, progress.getState());

		Calculation calcuation = CalculationRepository.insertCalculation(getGbpConnection(), new Calculation(), null);

		List<Integer> calculationIds = new ArrayList<Integer>();
		calculationIds.add(calcuation.getCalculationId());
		JobRepository.attachCalculations(getGbpConnection(), correlationId, calculationIds);

		JobRepository.updateJobStatus(getGbpConnection(), correlationId, JobState.RUNNING);
		progress = JobRepository.getProgress(getGbpConnection(), correlationId);
		assertEquals("Job must be running ", JobState.RUNNING, progress.getState());

		JobRepository.updateJobStatus(getGbpConnection(), correlationId, JobState.COMPLETED);
		progress = JobRepository.getProgress(getGbpConnection(), correlationId);
		assertEquals("Job must be completed ", JobState.COMPLETED, progress.getState());
	}

	@Test
	public void testGetCalculationsProgressForUser() throws SQLException {
		List<JobProgress> progresses;
		ScenarioUser user = UserRepository.getUserByApiKey(getGbpConnection(), TEST_API_KEY);
		assertNotNull("user found ", user);

		progresses = JobRepository.getProgressForUser(getGbpConnection(), user);
		assertEquals("Jobs count ", Boolean.TRUE , progresses.size()> 0);
	}
}
