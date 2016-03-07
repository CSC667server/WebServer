require 'socket'
require './http/request.rb'
require './http/respond.rb'
require './http/httpdConfig.rb'
require './http/mimeTypes.rb'
require './http/resource.rb'

class Server

	attr_reader :socket, :httpd_config, :mime_types

	def initialize(host="localhost", port=7777)
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
		httpd_file_path = "./config/httpd.conf"
		mime_file_path = "./config/mime.types"

		#HttpdConfig.new(read_config_file(httpd_file_path)).load.show_member
		#MimeTypes.new(read_config_file(mime_file_path)).load


		@http_config = HttpdConfig.new(read_config_file(httpd_file_path)).load
		@mime_types = MimeTypes.new(read_config_file(mime_file_path)).load
		resource = Resource.new("ab/", @http_config, @mime_types).resolve
		puts resource.path
		puts resource.mime_type

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
	
#Server.new.start
Server.new.config