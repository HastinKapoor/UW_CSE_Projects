
# Hastin Kapoor
# 2061247

require_relative "scan"

scanner = Scanner.new()

while(true)
	value = scanner.next_token()
	if (value.kind() == "quit" || value.kind() == "exit" || value.kind() == "EOF")
		break
	end
	puts ("#{value.to_s}" + "\n")
end