require 'faye/websocket'

module ChatDemo
  class ChatBackend
    KEEPALIVE_TIME = 15 # in seconds

    def initialize(app)
      @app = app
      @clients = []
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        # WebSockets logic goes here
        # initialize websocket
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})

        # call method to initialize websocket
        ws.on :open do |event|
          p [:open, ws.object_id]
          @clients << ws
        end

        # message gets invoked when websocket recieves it
        ws.on :message do |event|
          p [:message, event.data]
          @clients.each {|event| client.send(event.data)}
        end

        #close when clients closes connection
        ws.on :close do |event|
          p [:close, ws.object_id, event.code, event.reason]
          @clients.delete(ws)
          ws = nil
        end

        # Return async Rack response
        ws.rack_response
      else
        @app.call(env)
      end
    end


  end
end