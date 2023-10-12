
# Hastin Kapoor
# 2061247

require_relative "scan"

# names are rather self explanatory, parseXYZ handles
# parsing of the XYZ type in the grammar

class Calc
	def initialize()
		@scanner = Scanner.new()
		@currentToken = @scanner.next_token()
		@vars = Hash.new()
		@vars.store("PI", Math::PI)
		parseProgram()
	end
	
	def parseProgram()
	while (true)
		puts parseStatement()
		while(@currentToken.kind() == "EOL")
			@currentToken = @scanner.next_token()
			puts parseStatement()
		end
		@scanner = Scanner.new()
		@currentToken = @scanner.next_token()
		end
	end
	
	def parseStatement()
		result = nil
		case @currentToken.kind()
		when "quit"
			exit
		when "exit"
			exit
		when "list"
			return @vars
		when "clear"
			@currentToken = @scanner.next_token()
			var = @currentToken.value()
			@vars.delete(var)
			puts "#{var} value cleared"
		when "identifier"
			assign = @scanner.peek().value()
			if(assign == "=")
				var = @currentToken.value()
				@currentToken = @scanner.next_token()
				@currentToken = @scanner.next_token()
				value = parseExpression()
				@vars.store(var, value)
				puts "#{var} assigned with value #{value}"
			else
				result = parseExpression()
			end
		else
			result = parseExpression()
		end
		return result
	end
	
	def parseExpression()
		result = parseTerm()
		while(@currentToken.kind() == "+" || @currentToken.kind() == "-")
			if (@currentToken.kind() == "+")
				@currentToken = @scanner.next_token()
				result += parseTerm()
			else
				@currentToken = @scanner.next_token()
				result -= parseTerm()
			end
		end
		return result
	end
	
	def parseTerm()
		result = parsePower()
		while(@currentToken.kind() == "*" || @currentToken.kind() == "/")
			if(@currentToken.kind() == "*")
				@currentToken = @scanner.next_token()
				result *= parsePower()
			else
				@currentToken = @scanner.next_token()
				result /= parsePower()
			end
		end
		return result
	end
	
	def parsePower()
		result = parseFactor()
		while(@currentToken.kind() == "**")
			@currentToken = @scanner.next_token()
			result **= parseTerm()
		end
		return result
	end
	
	def parseFactor()
		result = nil
		case @currentToken.kind()
		when "identifier"
			if (@vars[@currentToken.value()] != nil)
				result = @vars[@currentToken.value()]
			else
				puts "#{@currentToken.value()} not defined"
			end
		when "number"
			result = @currentToken.value()
		when "("
			@currentToken = @scanner.next_token()
			result = parseExpression()
		when "sqrt"
			@currentToken = @scanner.next_token()
			@currentToken = @scanner.next_token()
			result = Math.sqrt(parseExpression())
		end
		@currentToken = @scanner.next_token()
		return result
	end
end

calc = Calc.new()