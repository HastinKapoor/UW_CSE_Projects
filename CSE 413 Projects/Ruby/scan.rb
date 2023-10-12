
# Hastin Kapoor
# 2061247

(require 'readline')

class Scanner
	def initialize()
		@input = gets.scan(/[A-Za-z][A-Za-z_0-9]+|\*\*|[+-]?\d+(?:\.\d+)?(?:[eE]?[+-]?\d+(?:\.\d+)?)?|\n|./).reject{|str| str.gsub(/\t| /, '').empty?}
		@index = -1
	end
	
	def next_token()
		@index += 1
		if(@index >= @input.length)
			return Token.new("EOF")
		end
		token = @input[@index]
		if("\n" == token)
			return Token.new("EOL")
		elsif("0123456789".include?(token[0]))
			if(token.include?("e") ||token.include?("E"))
				splitExp = token.split(/e|E/)
				return Token.new("number", (splitExp[0].to_f * 10 ** splitExp[1].to_f))
			else
				return Token.new("number", token.to_f)
			end
		elsif("+-**/()".include?(token) || "sqrt" == token || "quit" == token || "exit" == token || "list" == token || "clear" == token)
			return Token.new(token)
		else
			return Token.new("identifier", token)
		end
	end
	
	def peek()
		result = next_token()
		@index -=1
		return result
	end
end

class Token
	def initialize(k, v = nil)
		@kind = k
		@value = v
	end
	
	# returns one of the following, as a string: number, +, -, *, **, /, sqrt, (, ), identifier, quit, exit, EOL, EOF
	def kind()
		@kind
	end
	
	def value()
		@value
	end
	
	def to_s()
		result = @kind.to_s
		if (@value != nil)
			result += " " + @value.to_s
		end
		result
	end
end	