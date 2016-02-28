require './configFile.rb'

class HttpdConfig < ConfigFile

	attr_accessor :config

	def initialize(lines)
		super(lines)
	end

	def load()
		@config = process_lines
		return self
	end
end


lines = ["Listen 7777","ServerName localhost:7777"]

#puts HttpdConfig.new(lines).load
