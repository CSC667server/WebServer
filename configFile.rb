class ConfigFile 

	attr_accessor :lines, :directives

	def initialize(config)
		@lines = config
		@directives = {}
	end

	# filter and store config to @directives
	def load()
		@lines.each do |line|
			if line.length != 0 and line[0] != "#" and line[0] != "\n"
				directive, value = line.split(" ", 2)
				@directives.store(directive, value.chomp)
			end
		end

		return @directives
	end 

	# display @directive to console for testing
	def display()
		@directives.each do |key, value|
			puts "#{key} => #{value}"
		end
	end

end