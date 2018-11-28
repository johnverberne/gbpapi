package nl.rivm.nca.messagebus;

import java.io.IOException;

import com.rabbitmq.client.AMQP.BasicProperties;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.DefaultConsumer;
import com.rabbitmq.client.Envelope;

public abstract class Consumer extends DefaultConsumer {

	public Consumer(Channel channel) {
		super(channel);
	}

	@Override
	public final void handleDelivery(String consumerTag, Envelope envelope, BasicProperties properties, byte[] body)
			throws IOException {
		final Channel channel = getChannel();
		handleDelivery(properties.getCorrelationId(), body);
	    channel.basicAck(envelope.getDeliveryTag(), false);
	}

	protected abstract void handleDelivery(String correlationId, byte[] body);
}