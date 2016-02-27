require 'socket'
require './request.rb'
require './respond.rb'
require './configFile.rb'

class Server

	attr_accessor :socket, :httpd_config, :mime_type

	def initialize(host, port=7777)
		@socket = TCPServer.new(host, port) 
	end

	def start()
		while true
			puts "\nlistening for connection\n"
			client = socket.accept
			puts "\naccepted connection\n\n"

			Request.new(client).parse

			client.print Respond.new().to_s
			client.close
			puts "\nclosed connection\n"
		end
	end

	def config()

		#TO DO

		return self
	end

	def read_config_file(file_path)
		lines = []

		file = File.open(file_path, "r")

		file.readlines.each do |line|
			lines.push(line)
		end

		file.close

		return lines
	end
end
	
Server.new('localhost').start