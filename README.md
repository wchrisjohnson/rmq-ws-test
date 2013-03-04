rmq-ws-test
===========

Testbed to isolate rabbitmq/websocket interaction


## Setup local copy of this sample project

- git clone
- ensure the version of ruby and the gemset are consistent
- bundle install


## Install NodeJS (if not installed)

An installation of [NodeJS](http://nodejs.org) is required, but there are no other external dependencies. See [Benchmarking Web Socket servers with wsbench](http://blog.std.in/2010/09/24/benchmarking-web-socket-servers/) 

After install, check the version of node installed with:

node -v

The version should be >= 0.8.21


## Install wsbench tool

The source of this tool is available at https://github.com/pgriess/wsbench, and there are outstanding pull requests for patches, but the author doesn't seem to be willing to accept them for some reason.

1) Manually apply PR5 if it has not been merged:
https://github.com/pgriess/wsbench/pull/5

2) Manually apply PR8 if it has not been merged:
https://github.com/pgriess/wsbench/pull/8

3) Ensure that the wsbench file ix executable: 

chmod +x wsbench



## Start Thin webserver

bundle exec thin start -C thin.yml


## Use wsbench to generate websocket traffic

node wsbench -c 5 -r 10 ws://localhost:8080/websocket

This attempts to connect 5 times to the web socket.


## Errors 

Sample logfile contents:

```
>> Writing PID to thin.8080.pid
>> Using rack adapter
New AMQP connection.
WebSocket opened
WebSocket closed
Channel 1 opened.
WebSocket opened
Channel 3 opened.
Closing amqp channel 3
WebSocket closed
amqp channel 3 closed.
WebSocket opened
WebSocket closed
>> Exiting!
/Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amq-client-0.9.12/lib/amq/client/async/adapter.rb:248:in `send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x007fe8eb85b570 @payload="\x00\x14\x00\n\x00", @channel=3>, method class is AMQ::Protocol::Channel::Open (AMQ::Client::ConnectionClosedError)
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amq-client-0.9.12/lib/amq/client/async/channel.rb:110:in `open'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amqp-0.9.9/lib/amqp/channel.rb:914:in `open'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amqp-0.9.9/lib/amqp/channel.rb:235:in `block in initialize'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/eventmachine-1.0.1/lib/em/deferrable.rb:48:in `call'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/eventmachine-1.0.1/lib/em/deferrable.rb:48:in `callback'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amq-client-0.9.12/lib/amq/client/async/adapters/event_machine.rb:112:in `on_open'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amqp-0.9.9/lib/amqp/channel.rb:234:in `initialize'
	from /Users/wchrisjohnson/code/rmq-ws-test/web_socket_app.rb:16:in `new'
	from /Users/wchrisjohnson/code/rmq-ws-test/web_socket_app.rb:16:in `block (3 levels) in <top (required)>'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/em-websocket-0.3.8/lib/em-websocket/connection.rb:22:in `call'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/em-websocket-0.3.8/lib/em-websocket/connection.rb:22:in `trigger_on_open'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/em-websocket-0.3.8/lib/em-websocket/handler.rb:18:in `run'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/em-websocket-0.3.8/lib/em-websocket/connection.rb:116:in `dispatch'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/em-websocket-0.3.8/lib/em-websocket/connection.rb:73:in `receive_data'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/eventmachine-1.0.1/lib/eventmachine.rb:187:in `run_machine'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/eventmachine-1.0.1/lib/eventmachine.rb:187:in `run'
	from /Users/wchrisjohnson/code/rmq-ws-test/web_socket_app.rb:4:in `<top (required)>'
	from /Users/wchrisjohnson/code/rmq-ws-test/wrapper_app.rb:3:in `require_relative'
	from /Users/wchrisjohnson/code/rmq-ws-test/wrapper_app.rb:3:in `<top (required)>'
	from /Users/wchrisjohnson/code/rmq-ws-test/config.ru:1:in `require'
	from /Users/wchrisjohnson/code/rmq-ws-test/config.ru:1:in `block in <main>'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/rack-1.5.2/lib/rack/builder.rb:55:in `instance_eval'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/rack-1.5.2/lib/rack/builder.rb:55:in `initialize'
	from /Users/wchrisjohnson/code/rmq-ws-test/config.ru:1:in `new'
	from /Users/wchrisjohnson/code/rmq-ws-test/config.ru:1:in `<main>'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/rack/adapter/loader.rb:33:in `eval'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/rack/adapter/loader.rb:33:in `load'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/rack/adapter/loader.rb:42:in `for'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/thin/controllers/controller.rb:169:in `load_adapter'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/thin/controllers/controller.rb:73:in `start'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/thin/runner.rb:187:in `run_command'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/lib/thin/runner.rb:152:in `run!'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/thin-1.5.0/bin/thin:6:in `<top (required)>'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/bin/thin:23:in `load'
	from /Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/bin/thin:23:in `<main>'

```


RabbitMQ logfile entries:

```
=INFO REPORT==== 4-Mar-2013::00:28:14 ===
accepting AMQP connection <0.4446.4> (localhost:51997 -> localhost:5672)

=INFO REPORT==== 4-Mar-2013::00:28:25 ===
accepting AMQP connection <0.4465.4> (localhost:51999 -> localhost:5672)

=ERROR REPORT==== 4-Mar-2013::00:28:25 ===
AMQP connection <0.4465.4> (running), channel 3 - error:
{amqp_error,channel_error,"expected 'channel.open'",'queue.bind'}

=WARNING REPORT==== 4-Mar-2013::00:28:25 ===
closing AMQP connection <0.4446.4> (localhost:51997 -> localhost:5672):
connection_closed_abruptly

=INFO REPORT==== 4-Mar-2013::00:28:25 ===
closing AMQP connection <0.4465.4> (localhost:51999 -> localhost:5672)
```




The error can be prevented by removing/commenting out the channel close logic inside the web_socket_app.