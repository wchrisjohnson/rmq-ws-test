rmq-ws-test
===========

Testbed to isolate rabbitmq/websocket interaction


## Setup local copy of this sample project

- git clone https://git.hpcloud.net/chrjohns/rmq-ws-test
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

Generally, the failure occurs at some point after the first AMQP channel close (see below).

```
>> Writing PID to thin.8080.pid
>> Using rack adapter
WebSocket opened
WebSocket closed
WebSocket opened
WebSocket closed
Closing amqp channel
WebSocket opened
WebSocket closed
>> Exiting!
/Users/wchrisjohnson/.rvm/gems/ruby-1.9.3-p374@rmq-ws-test/gems/amq-client-0.9.12/lib/amq/client/async/adapter.rb:248:in `send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x007fcdd2947e90 @payload="\x00\x14\x00\n\x00", @channel=3>, method class is AMQ::Protocol::Channel::Open (AMQ::Client::ConnectionClosedError)
...

```


The error can be prevented by removing/commenting out the channel close logic inside the web_socket_app.