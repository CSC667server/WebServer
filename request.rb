class Request

	attr_accessor :stream, :method, :identifier, :query
	attr_accessor :version, :header, :body

	def initialize(socket)
		@stream = socket_to_s(socket)
		@headers = {}
	end

	def parse()

		# break stream into 3 parts
		request_line = seperate_request_line
		headers = seperate_headers
		@body = seperate_body

		# parsing each parts
		extract_request_line(request_line)
		extract_headers(headers)

		# show info in console
		display_info_to_console
	end

	# print component to console (remove later)
	def display_info_to_console()
		puts "method: #{@method}"
		puts "identifier: #{@identifier}"
		puts "query: #{@query}"
		puts "version: #{@version}"
		puts "---------------- headers ----------------"
		puts @headers
		puts "---------------- body -------------------"
		puts @body
	end

	# parse request-line
	def extract_request_line(request_line)
		field = request_line.split(' ', 4)
		@method = field[0]
		@identifier = field[1]
		@version = field[2]
		@query = extract_query
	end

	# parse header field & store into @headers hash
	def extract_headers(header_fields)
		header_fields.each_line { |field|
			name = field.split(": ", 2)[0]
			value = field.split(": ", 2)[1].chomp
			@headers.store(name, value)
		}
	end

	# parse query string from @identifier
	# MUST be call after @identifier is parsed
	def extract_query
		@identifier.split("?", 2)[1]
	end

	# breaks and return body from stream 
	def seperate_body()
		@stream.split("\n\n", 2)[1]
	end

	# breaks and return 1st line from stream
	def seperate_request_line()
		@stream.split("\n", 2)[0]
	end

	# breaks and return headers from stream
	def seperate_headers()
		@stream.split("\n\n")[0].split("\n", 2)[1]
	end

	def socket_to_s(socket)
		stream = ""
		while (line = socket.gets) != "\r\n"
				stream += line
		end
		return stream
	end
end