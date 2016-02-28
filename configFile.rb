class ConfigFile 

	attr_accessor :lines, :directives

	def initialize(lines)
		@lines = lines
		@directives = {}
	end

	# filter and store lines to @directives
	# returns @directives hash
	def process_lines()
		@lines.each do |line|
			if line.length != 0 and line[0] != "#" and line[0] != "\n"
				directive, argument = line.split(" ", 2)
				@directives.store(directive, argument.chomp)
			end
		end

		return @directives
	end 

	# display @directive to console for testing
	def show_config()
		@directives.each do |key, value|
			puts "#{key} => #{value}"
		end

		return self
	end

end