require './configFile.rb'

class MimeTypes < ConfigFile

	attr_accessor :config

	def initialize(lines) 
		super(lines)
	end

	def load()
		@config = process_lines
		return self
	end

	def for(ext)
		return @config[ext]
	end

end

#mime_file = File.open("./config/mime.types", "r")
#puts mime_file.read.class

def read_config_file(file_path)
	lines = []

	file = File.open(file_path, "r")

	file.readlines.each do |line|
		lines.push(line)
	end

	file.close

	return lines
end

file = read_config_file("./config/mime.types")

puts MimeTypes.new(file).load.for(".avi")