require 'socket'
require './request.rb'
require './respond.rb'

class Server

	attr_accessor :host, :port, :socket

	def initialize(host, port=4444)
		@socket = TCPServer.new(host, port) 
	end

	def start
		while true
			puts "\nlistening for connection\n"
			client = socket.accept
			puts "\naccepted connection\n\n"
			
			stream = ""
			while (line = client.gets) != "\r\n"
				stream += line
			end
			
			request = Request.new(stream).parse
			respond = Respond.new(request).to_s

			client.print respond

			client.close
			puts "\nclosed connection\n"
		end
	end
end
	
Server.new('localhost').start