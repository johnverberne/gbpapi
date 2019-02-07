package nl.rivm.nca.api.service.impl;

import java.io.File;
import java.io.IOException;
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
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.AssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.pcraster.Controller;
import nl.rivm.nca.pcraster.SingleRun;

public class AssessmentRequestApiServiceImpl extends AssessmentRequestApiService {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssessmentRequestApiServiceImpl.class);

	@Override
	public Response postAssessmentRequest(AssessmentRequest assessmentRequest, SecurityContext securityContext)
			throws NotFoundException {
		return Response.ok().entity(postRequest(assessmentRequest)).build();
	}

	private ValidateResponse postRequest(AssessmentRequest ar) {
		final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
		ArrayList<ValidationMessage> warnings = new ArrayList<ValidationMessage>();
		List<ValidationMessage> errors = new ArrayList<ValidationMessage>();
		result.setWarnings(warnings);
		result.setErrors(errors);

		if (ar.getModel() != ModelEnum.AIR_REGULATION) {
			warnings.add(WarningUtil.ValidationInfoMessage("EcoSystem not implemented yet."));

		} else {
			// build a request.
			final String uuid = UUID.randomUUID().toString();
			try {
				// call runner direct later run as MQ task
				assessmentRun(ar, warnings, uuid);
				result.setSuccessful(true);

			} catch (ConfigurationException | IOException | InterruptedException e) {
				ValidationMessage message = new ValidationMessage();
				message.setCode(1);
				message.setMessage("error is call : " + e.getMessage());
				errors.add(WarningUtil.ValidationInfoMessage("Task executed uuid:" + uuid));
				result.setErrors(errors);
				LOGGER.info("error in call {}", e.getMessage());
			}
		}
		return result;
	}

	private void assessmentRun(AssessmentRequest ar, ArrayList<ValidationMessage> warnings, final String uuid)
			throws IOException, ConfigurationException, InterruptedException {
		final Controller controller = initController(true);
		final SingleRun singleRun = new SingleRun();
		controller.run(uuid,
				singleRun.singleRun(ar.getName(), "air_regulation", "/opt/nkmodel/nkmodel_scenario_trees/"));
		warnings.add(WarningUtil.ValidationInfoMessage("Task executed uuid:" + uuid));
	}

	private Controller initController(boolean directFile) throws IOException, InterruptedException {
		final String ncaModel = System.getenv("NCA_MODEL");
		if (ncaModel == null) {
			throw new IllegalArgumentException(
					"Environment variable 'NCA_MODEL' not set. This should point to the raster data");
		}
		return new Controller(new File(ncaModel), directFile);
	}

}