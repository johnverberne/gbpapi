package nl.rivm.nca.db;

import static org.junit.Assert.assertNotEquals;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import org.junit.Test;

import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.db.GbpRepository;

public class CalculationRepositoryTest {

  private Connection getConnection() {
    return null;
  }
  
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
  
  
  
}
