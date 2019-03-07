package nl.rivm.nca.db.calculation;

import static org.junit.Assert.assertNotEquals;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import org.junit.Test;

import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.db.GbpRepository;
import nl.rivm.nca.db.TestPMF;

public class CalculationRepositoryTest {
  
  @Test
  public void testInsertCalculation() throws SQLException {
    final String uuid = UUID.randomUUID().toString();
    int createdCalculation = GbpRepository.insertCalculation(getConnection(), uuid);
    assertNotEquals("Calculation ID", 0, createdCalculation);
  }
  
  @Test
  public void testInsertCalculationResult() throws SQLException {
    final String uuid = UUID.randomUUID().toString();
    int createdCalculationId = GbpRepository.insertCalculation(getConnection(), uuid);
    
    for(int i=1; i<4; i++){
      GbpRepository.insertCalculationResult(getConnection(), createdCalculationId, "{}");
    }
    List<AssessmentResultResponse> list = GbpRepository.getCalculationResult(getConnection(), uuid);
    assertNotEquals("CalculationResult", 0, list.size());
  }
  
	protected Connection getConnection() throws SQLException {
		TestPMF pmf = new TestPMF(true);
		pmf.setJdbcURL("jdbc:postgresql://localhost/unittest_NCA-gbp");
		pmf.setDbUsername("aerius");
		pmf.setDbPassword("hallo2dirk337");
		return pmf.getConnection();
	}
  
  
}
