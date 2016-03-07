require './http/configFile.rb'

class HttpdConfig < ConfigFile

	attr_reader :config, :server_root, :listen, :document_root, :log_file
	attr_reader :alias, :script_alias, :access_file_name, :directory_index

	DEFAULT_PORT = 7777

	def initialize(lines)
		super(lines)
		@alias = {}
		@script_alias = {}
	end

	def load()
		@config = super

		# store corresponding config to instance variable
		@server_root = @config["ServerRoot"]
		@listen = @config.fetch("Listen", DEFAULT_PORT)
		@document_root = @config.fetch("DocumentRoot", "/public_html/")
		@log_file = @config["LogFile"]
		@alias = @config["Alias"]
		@script_alias = @config["ScriptAlias"]

		return self
	end

	def show_member()
		puts "server_root = #{@server_root}"
		puts "listen = #{@listen}"
		puts "document_root = #{@document_root}"
		puts "log_file = #{@log_file}"
		puts "alias = #{@alias}"
		puts "script_alias = #{@script_alias}"

		return self
	end
end