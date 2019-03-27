package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeoutException;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import nl.rivm.nca.api.domain.AssessmentRequest;
import nl.rivm.nca.api.domain.AssessmentRequest.ModelEnum;
import nl.rivm.nca.messagebus.ConnectionHelper;
import nl.rivm.nca.messagebus.Consumer;

//      "data": "file://home/hilbrand/workspace/ank/nca/nca/nca-pcraster/src/test/resources/bomen.tiff"
public class Main {

	private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);

	private static final String QUEUE_NAME = "nca.pcraster";

	private final ObjectMapper mapper = new ObjectMapper();
	private final ControllerInterface controller;

	public Main(boolean directFile) throws IOException, InterruptedException {
		final String ncaModel = System.getenv("NCA_MODEL");
		if (ncaModel == null) {
			throw new IllegalArgumentException(
					"Environment variable 'NCA_MODEL' not set. This should point to the raster data");
		}
		//support multi model based on NCA_MODEL
		//controller = new NkModelController(new File(ncaModel), directFile);
		controller = new NkModel2Controller(new File(ncaModel), directFile);
	}

	public static void main(final String[] args) throws IOException, TimeoutException, InterruptedException {
		final ExecutorService executorService = Executors.newFixedThreadPool(1);

		try {
			final ConnectionFactory factory = ConnectionHelper.createFactory();
			final boolean singleRun = args.length == 4;

			LOGGER.info("lets start with model: {} {} {} {}", args[0], args[1], args[2], args[3]);

			final Main main = new Main(singleRun);
			if (singleRun) {

				main.singleRun(args);
			} else {
				main.start(factory.newConnection(executorService), QUEUE_NAME);
			}
		} finally {
			executorService.shutdown();
		}
	}

	/**
	 * A single run which requires the following arguments:
	 * <p>
	 * args[0]: user defined name
	 * <p>
	 * args[1]: model to run, i.e: air_regulation
	 * <p>
	 * args[2]: directory with geotiff files to use as input. Files must match
	 * the name as used by the model.
	 * <p>
	 * args[3]: input type tiff or xyz files.
	 *
	 * @param args
	 * @throws IOException
	 */
	private void singleRun(final String[] args) throws IOException {
		final String uuid = UUID.randomUUID().toString();
		final SingleRun singleRun = new SingleRun();
		runAssessment(uuid, singleRun.singleRun(args[0], args[1], args[2], args[3], ModelEnum.NKMODEL));
	}

	/**
	 * Runs the application as a service listening to a queue.
	 * 
	 * @param connection
	 * @param queueName
	 * @return
	 * @throws IOException
	 * @throws InterruptedException
	 */
	private Channel start(Connection connection, String queueName) throws IOException, InterruptedException {
		final Channel channel = connection.createChannel();
		final Consumer workerConsumer = new Consumer(channel) {
			@Override
			protected void handleDelivery(String correlationId, byte[] body) {
				try {
					runAssessment(correlationId, mapper.readValue(body, AssessmentRequest.class));
				} catch (final IOException e) {
					throw new RuntimeException("Running model failed.", e);
				}
			}
		};
		channel.basicQos(1);
		channel.basicConsume(queueName, false, queueName, workerConsumer);
		return channel;
	}

	private void runAssessment(String correlationId, AssessmentRequest ar) {
		try {
			LOGGER.info("AssessmentRequest {}", ar.toString());
			controller.run(correlationId, ar);
		} catch (IOException | ConfigurationException e) {
			e.printStackTrace();
			throw new RuntimeException("Running model failed.", e);
		} catch (final InterruptedException e) {
			Thread.currentThread().interrupt();
		}
	}
}
