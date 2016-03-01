require './request.rb'
class Resource
	attr_accessor :request, :conf, :mims, :resolved_path, :final_uri

	def initialize(request, httpd_conf, mimes)
		@request = request
		@path = request.identifier.dup
		@conf = httpd_conf
		@mimes = mimes
		@resolved_path = ""
		@final_uri = nil

	end
	
	def full_uri
		@final_uri ||= begin
			whole_path = File.join(@conf.document_root, @path)
			if File.file?(whole_path) || @request.method == "PUT" || @request.method == "DELETE"
				@request.identifier
			else
				File.join(@path. @conf.directory_index)
			end
		end
		@final_uri
	end
	
	def resolve
		full_uri
		if !script_aliased? && !aliased?
			@resolved_path = File.join(@conf.document_root, @final_uri)
		end
		if 
	end
	
	def create_resource
		
	end
	
	
end	
