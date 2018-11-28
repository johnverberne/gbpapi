package nl.rivm.nca.messagebus;

import com.rabbitmq.client.ConnectionFactory;

public class ConnectionHelper {

	public static ConnectionFactory createFactory() {
		final ConnectionFactory factory = new ConnectionFactory();
		factory.setHost(getEnv("HOST"));
		factory.setUsername(getEnv("USERNAME"));
		factory.setPassword(getEnv("PASSWORD"));
		return factory;
	}

	private static String getEnv(String param) {
		return System.getenv("RABBITMQ_" + param);
	}


}
