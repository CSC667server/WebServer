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
		puts "\n\nmethod: #{@method}"
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
end

request_str = "GET / HTTP/1.1
Host: localhost:5555
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:44.0) Gecko/20100101 Firefox/44.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Connection: keep-alive
Cache-Control: max-age=0\n\nbody: bla bla bla"

#Request.new(request_str).parse

#request = Request.new
#puts request_str
#request.extract_request_line(request_str)

#request.parse(request_str)

#puts "\n\nmethod: #{request.method}"
#puts "identifier: #{request.identifier}"
#puts "version: #{request.version}"


#test = {}
#puts test.class