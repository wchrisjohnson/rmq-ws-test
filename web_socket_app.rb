require 'em-websocket'
require 'amqp'

EventMachine.run do 
  
  if AMQP.connection && AMQP.connection.connected? 
    puts "AMQP connected."
  else
    puts "New AMQP connection."
    AMQP.connect(:host => 'localhost')
  end

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen do
      puts "WebSocket opened"
      AMQP::Channel.new do |channel, open_ok|
        channel.once_open do
          @mychannel = channel
          puts "Channel #{@mychannel.id} opened."
          @mychannel.queue( AMQ::Protocol::EMPTY_STRING, 
                            durable: true,
                            exclusive: true,
                            auto_delete: true).bind(@mychannel.direct("platform.alert",durable: true),routing_key: 'critical').subscribe do |t|
          end # queue
        end # channel.once_open
      end # AMQP::Channel.new
    end # ws.onopen

    ws.onclose do
      if AMQP.connection.connected? && @mychannel && @mychannel.open?
        puts "Closing amqp channel #{@mychannel.id}"
        @mychannel.close do |close_ok|
          puts "amqp channel #{@mychannel.id} closed."
        end
      end
      puts "WebSocket closed"
    end  
  end
end