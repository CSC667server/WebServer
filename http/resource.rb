class Resource
	attr_reader :uri, :httpd_conf, :mime_types, :path

	def initialize(uri, httpd_conf, mime_types)
		@uri = uri
		@httpd_conf = httpd_conf
		@mime_types = mime_types
	end

	def resolve
		if uri == httpd_conf.script_alias.split(" ", 2)[0]
			@path = httpd_conf.script_alias.split(" ", 2)[1]
		elsif uri == httpd_conf.alias.split(" ", 2)[0]
			@path = httpd_conf.alias.split(" ", 2)[1]
		elsif uri == "/"
			@path = "index.html"
		else
			@path = uri
		end

		if path.end_with?("/")
			@path += "index.html"
		end

		@path = httpd_conf.document_root + @path
		
		return self
	end

	def mime_type
		if uri.include?(".")
			ext = uri
		else
			resolve
			ext = @path
		end

		ext = ext.split(".", 2).last

		return mime_types.for(ext) 
	end

	def script?

	end


end