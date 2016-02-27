require 'date'
require './request.rb'

class Respond
	
	attr_accessor :version, :status_code, :reason_phrase
	attr_accessor :headers, :body, :request

	def initialize(request)
		@version = ""
		@status_code = ""
		@reason_phrase = ""
		@headers = {}
		@body = ""
		@request = request
	end

	# return respond as a string
	def to_s()
		#using example for testing 
		use_example

		status_line = "#{@version} #{@status_code} #{@reason_phrase}\n"
		@headers.each do |key, value|
			status_line += "#{key}: #{value}\n"
		end

		status_line += "\n#{body}\n"
	end

	# create an example respond
	def use_example()
		@body = "This is body with some payload.\n"
		@body += "below is client's request:\n\n#{@request.stream}"
		@version = "HTTP/1.1"
		@status_code = "200"
		@reason_phrase = "OK"
		@headers.store("Date", "#{Time.now.strftime("%d/%m/%Y")}")
		@headers.store("Server", "The best one")
		@headers.store("Content-Type", "text")
		@headers.store("Content-Length", "#{@body.bytesize}")
	end
 
end