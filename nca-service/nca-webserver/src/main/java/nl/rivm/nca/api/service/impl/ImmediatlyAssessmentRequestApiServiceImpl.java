package nl.rivm.nca.api.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentRequest.ModelEnum;
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.ImmediatlyAssessmentRequestResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.ImmediatlyAssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.db.calculation.CalculationRepository;
import nl.rivm.nca.db.user.UserRepository;
import nl.rivm.nca.pcraster.ImmediatlyController;
import nl.rivm.nca.pcraster.SingleRun;
import nl.rivm.nca.shared.domain.calculation.Calculation;
import nl.rivm.nca.shared.domain.user.ScenarioUser;

public class ImmediatlyAssessmentRequestApiServiceImpl extends ImmediatlyAssessmentRequestApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(ImmediatlyAssessmentRequestApiServiceImpl.class);
  
	private final ApiServiceContext context;
	
	public ImmediatlyAssessmentRequestApiServiceImpl() {
		this(new ApiServiceContext());
	}

	ImmediatlyAssessmentRequestApiServiceImpl(final ApiServiceContext context) {
		this.context = context;
	}

  @Override
  public Response postImmediatlyAssessmentRequest(AssessmentRequest assessmentRequest, SecurityContext securityContext)
      throws NotFoundException {
    ImmediatlyAssessmentRequestResponse response = calculate(assessmentRequest);
    return Response.ok().entity(response).build();
  }

  private ImmediatlyAssessmentRequestResponse calculate(AssessmentRequest ar) {
    final ImmediatlyAssessmentRequestResponse response = new ImmediatlyAssessmentRequestResponse();
    ArrayList<ValidationMessage> warnings = new ArrayList<ValidationMessage>();
    List<ValidationMessage> errors = new ArrayList<ValidationMessage>();
    response.setWarnings(warnings);
    response.setErrors(errors);

    if (ar.getModel() != ModelEnum.NKMODEL) {
      warnings.add(WarningUtil.ValidationInfoMessage("Only NKMODEL is allowed."));

    } else {
      final String uuid = UUID.randomUUID().toString();
      try  (final Connection connection = context.getPMF().getConnection()) {
    	ScenarioUser user = UserRepository.getUserByApiKey(connection, "0000-0000-0000-0000");
        Calculation calc = CalculationRepository.insertCalculation(connection, new Calculation(), uuid, user, ar.getName());
    	  
        response.setKey(uuid);
        List<AssessmentResultResponse> modelResults = assessmentRun(ar, warnings, uuid);
        CalculationRepository.insertCalculationResults(connection,calc.getCalculationId(),uuid,modelResults);
        response.setAssessmentResults(modelResults);
        response.setSuccessful(true);

      } catch (ConfigurationException | IOException | InterruptedException | SQLException e) {
        ValidationMessage message = new ValidationMessage();
        message.setCode(1);
        message.setMessage("error is call : " + e.getMessage());
        errors.add(WarningUtil.ValidationInfoMessage("Task executed uuid:" + uuid));
        response.setErrors(errors);
        LOGGER.info("error in call {}", e.getMessage());
        response.setSuccessful(false);
	}
    }
    return response;
  }

  private List<AssessmentResultResponse> assessmentRun(AssessmentRequest ar, ArrayList<ValidationMessage> warnings, final String uuid)
      throws IOException, ConfigurationException, InterruptedException {
    final ImmediatlyController controller = initController(true);
    final SingleRun singleRun = new SingleRun();
    List<String> models = new ArrayList<String>();
    models.add("air_regulation");
    //models.add("cooling_in_urban_areas");
    //models.add("energy_savings_by_shelter_trees");
    
    List<AssessmentResultResponse> results = new ArrayList<AssessmentResultResponse>();
		for (String model : models) {
			ModelEnum runModel = ModelEnum.NKMODEL;
			results.addAll(controller.run(uuid, singleRun.singleRun(ar.getName(), model, "/opt/nkmodel/nkmodel_scenario_trees/", SingleRun.GEOTIFF_EXT,runModel )));
		}
    return results;
  }

  private ImmediatlyController initController(boolean directFile) throws IOException, InterruptedException {
    final String ncaModel = System.getenv("NCA_MODEL");
    if (ncaModel == null) {
      throw new IllegalArgumentException(
          "Environment variable 'NCA_MODEL' not set. This should point to the raster data");
    }
    return new ImmediatlyController(new File(ncaModel), directFile);
  }

}
