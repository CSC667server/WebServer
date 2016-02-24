class Request

	attr_accessor :stream
	attr_accessor :method, :identifier, :query
	attr_accessor :version, :header, :body

	def initialize(stream)
		@stream = stream
		@method = ""
		@identifier = ""
		@query = ""
		@version = ""
		@headers = {}
		@body = ""
	end

	def parse()
		request_line = seperate_request_line
		headers = seperate_headers
		@body = seperate_body

		extract_request_line(request_line)
		extract_headers(headers)

		# print component to console (remove later)
		puts "method: #{@method}"
		puts "identifier: #{@identifier}"
		puts "query: #{@query}"
		puts "version: #{@version}"
		puts "---------------- headers ----------------"
		puts @headers
		puts "---------------- body -------------------"
		puts @body

		return self
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
end