package nl.rivm.nca.db.calculation;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import org.junit.Before;
import org.junit.Test;

import nl.rivm.nca.db.BaseDBTest;
import nl.rivm.nca.shared.domain.calculation.Calculation;
import nl.rivm.nca.shared.domain.calculation.CalculationResult;

public class CalculationRepositoryTest extends BaseDBTest {

	@Before
	public void changeAutoCommit() throws SQLException {
		Connection connection = getGbpConnection();
		connection.setAutoCommit(false); // use this to keep results in database.
	}
	
	@Test
	public void testInsertCalculation() throws SQLException {
		final String uuid = UUID.randomUUID().toString();
		Calculation calculation = CalculationRepository.insertCalculation(getGbpConnection(), new Calculation(), uuid);
		assertNotEquals("Calculation ID", 0, calculation.getCalculationId());
		assertNotEquals("Calculation ID", null, calculation.getCreationDate());

	}

	@Test
	public void testInsertCalculationResult() throws SQLException {
		final int MAX_ROWS = 4;
		final String uuid = UUID.randomUUID().toString();
		Calculation calculation = CalculationRepository.insertCalculation(getGbpConnection(), new Calculation(), uuid);

		int id;
		for (int i = 1; i <= MAX_ROWS; i++) {
			id = CalculationRepository.insertCalculationResult(getGbpConnection(), calculation.getCalculationId(),
					"model", "url", "{json}");
			assertNotEquals("CalculationResult", 0, id);
		}

		List<CalculationResult> calculationResults = CalculationRepository.getCalculationResult(getGbpConnection(),
				calculation.getCalculationId());
		assertNotEquals("CalculationResult should be ", 0, calculationResults.size());
		assertTrue("CalculationResult size would we " + MAX_ROWS + " is " + calculationResults.size(),
				calculationResults.size() == MAX_ROWS);
	}

}
