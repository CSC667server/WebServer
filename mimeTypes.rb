require './configFile.rb'

class MimeTypes < ConfigFile

	attr_accessor :config

	def initialize(lines) 
		super(lines)
	end

	def load()
		@config = super

		# store corresponding config to instance variable

		return self
	end

	def for(ext)
		
		@config.each_value do |all_ext|
			if all_ext.include? ext
				return @config.key(all_ext)
			end
		end

		return ext + " format is currently not supported."
	end
end