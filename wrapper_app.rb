require 'rack'
require 'thin'
require_relative 'web_socket_app'

class WrapperApp

  def initialize

    @app = Rack::Builder.new do
      
      map '/websocket' do
        run WebSocketApp.new
      end

    end
  end

  def call(env)
    @app.call(env)
  end
end
