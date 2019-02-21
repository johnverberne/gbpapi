package nl.rivm.nca.db;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import nl.rivm.nca.api.domain.AssessmentResultResponse;

public class GbpRepository {
  
  private GbpRepository() {};

  public static int insertCalculation(Connection connection, String uuid) {
    return 0;
  }
  
  public static void insertCalculationResult(Connection connection, int calculationId, String json ) {
    
  }

  public static List<AssessmentResultResponse> getCalculationResult(Connection connection, String uuid) {
    return new ArrayList<AssessmentResultResponse>();
  }
  
}
