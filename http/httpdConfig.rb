require './http/configFile.rb'

class HttpdConfig < ConfigFile

	attr_accessor :config

	def initialize(lines)
		super(lines)
	end

	def load()
		@config = super

		# store corresponding config to instance variable

		return self
	end
end