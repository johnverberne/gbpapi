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
import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.AssessmentRequestApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.pcraster.ControllerInterface;
import nl.rivm.nca.pcraster.NkModel2Controller;
import nl.rivm.nca.pcraster.NkModelController;

/*
 *  This function collects the data and parse to the model.
 *  After the model has run store the returned json list to the database.
 */
public class AssessmentRequestApiServiceImpl extends AssessmentRequestApiService {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssessmentRequestApiServiceImpl.class);
	
	private final ApiServiceContext context;
	
	public AssessmentRequestApiServiceImpl() {
		this(new ApiServiceContext());
	}

	AssessmentRequestApiServiceImpl(final ApiServiceContext context) {
		this.context = context;
	}

	@Override
	public Response postAssessmentRequest(String apiKey, AssessmentRequest assessmentRequest, SecurityContext securityContext)
			throws NotFoundException {
		return Response.ok().entity(postRequest(apiKey, assessmentRequest)).build();
	}

	private ValidateResponse postRequest(String apiKey, AssessmentRequest ar) {
		final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
		ArrayList<ValidationMessage> warnings = new ArrayList<ValidationMessage>();
		List<ValidationMessage> errors = new ArrayList<ValidationMessage>();
		result.setWarnings(warnings);
		result.setErrors(errors);

		if (ar.getModel() != ModelEnum.NKMODEL2) {
			warnings.add(WarningUtil.ValidationInfoMessage("Only NKMODEL2 is allowed."));

		} else {
			// build a request.
			final String uuid = UUID.randomUUID().toString();
			try {
				// call runner direct later run as MQ task
				final String inputDirectory = ""; // extractImportFile(ar, warnings, uuid);
				assessmentRun(ar, inputDirectory, warnings, uuid);
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

	private void assessmentRun(AssessmentRequest ar, String outputDirectory, ArrayList<ValidationMessage> warnings,
			final String uuid) throws IOException, ConfigurationException, InterruptedException {
		final ControllerInterface controller = initModelController(ar.getModel(), true);
		/* run hardcoded
		final SingleRun singleRun = new SingleRun();
		AssessmentRequest customAr = singleRun.singleRun(ar.getName(),"air_regulation", "/opt/nkmodel/nkmodel_scenario_trees", SingleRun.GEOTIFF_EXT);
		controller.run(uuid, customAr);
		*/
		LOGGER.info("API requestname '{}' exceute model '{}' request.", ar.getName(), ar.getEcoSystemService());
		List<AssessmentResultResponse> result = controller.run(uuid, ar);
		// write to database
		
		warnings.add(WarningUtil.ValidationInfoMessage("Task executed uuid:" + uuid));
	}

	private ControllerInterface initModelController(ModelEnum modelEnum, boolean directFile)
			throws IOException, InterruptedException {
		// get the environment for the supplied model.
		ControllerInterface controller;
		final String ncaModel = System.getenv("NCA_MODEL_" + modelEnum.toString().toUpperCase());
		if (ncaModel == null) {
			throw new IllegalArgumentException(
					"Environment variable 'NCA_MODEL' not set. This should point to the raster data");
		} else {
			if (modelEnum == ModelEnum.NKMODEL) {
				controller = new NkModelController(new File(ncaModel), directFile);
			} else {
				controller = new NkModel2Controller(new File(ncaModel), directFile);
			}
		}
		return controller;
	}

/*
	private String extractImportFile(AssessmentRequest ar, ArrayList<ValidationMessage> warnings, String uuid)
			throws IOException {
		final File inputWorkingPath = Files.createTempDirectory(UUID.randomUUID().toString()).toFile();
		LOGGER.info("Writing {} input files to temp directory", ar.getLayers().size());
		for (LayerObject layer : ar.getLayers()) {
			String fileName = layer.getClassType() + "." + layer.getDataType();

			BufferedWriter output = null;
			// FileOutputStream output = null;
			// FileOutputStream output =null;
			try {
				final File projectFile = new File(inputWorkingPath, fileName);
				// write static content for test
				output = new BufferedWriter(new FileWriter(projectFile));
				output.write("140810.699379817495 459491.563811304339 0.1\n"
						+ "140820.671979452542 459491.563811304339 0.2\n"
						+ "140830.644579087588 459491.563811304339 0.3\n"
						+ "142147.027730912407 458583.740768695658 0.4\n"
						+ "142157.000330547453 458583.740768695658 0.5\n"
						+ "142166.972930182499 458583.740768695658 0.6");

				// this does not work
				byte[] byteArray = Base64.decodeBase64(layer.getData());
				String str = new String(byteArray, StandardCharsets.UTF_8);
				LOGGER.info("BASE64 to to text : {}", str);
				// output.write(byteArray);

			} catch (IOException e) {
				// no throw error
				e.printStackTrace();
			} finally {
				if (output != null) {
					output.close();
				}
			}
			LOGGER.info("Writing input to temp directory {} {} {} {}", inputWorkingPath, layer.getClassType(),
					layer.getDataType(), layer.getData());
		}
		return inputWorkingPath.getPath();
	}
	*/

}