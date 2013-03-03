require 'em-websocket'
require 'amqp'

def self.amqp_channels
  @amqp_channels ||= {}
end

def self.amqp_connection
  EventMachine.next_tick do
    if @amqp_connection
      puts "Using existing connection"
    else
      puts "Creating new connection"
      @amqp_connection = AMQP.connect(:host => 'localhost')
    end # if @amqp_connection...
    @amqp_connection
  end
end

EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
  ws.onopen do
    puts "WebSocket opened"
    AMQP::Channel.new(self.amqp_connection) do |channel, open_ok|
      amqp_channels[self.object_id] = channel
      channel.queue(AMQ::Protocol::EMPTY_STRING, durable: true,exclusive: true,auto_delete: true).bind(channel.direct("platform.alert",durable: true),routing_key: 'critical').subscribe do |t|
        puts 'got a message'
        ws.send t
      end
    end
  end

  ws.onclose do
    EventMachine.next_tick do
      channel = amqp_channels[self.object_id]
      if channel && channel.open?
        channel.close do |close_ok|
          puts "Closing amqp channel"
          amqp_channels.delete(self.object_id)
        end
      end
    end
    puts "WebSocket closed"
  end
end
