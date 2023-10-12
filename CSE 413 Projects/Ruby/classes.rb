
# Hastin Kapoor
# 2061247

class Document
	def initialize()
		@history = Array.new
		@contents = String.new
		@modified = Time.new
	end
	
	def contents=(new_contents)
		@history.append(@contents)
		@contents = new_contents
		@modified = Time.now
	end
	
	def contents()
		@contents
	end
	
	def modified()
		@modified
	end
	
	def size()
		@contents.length()
	end
	
	def undo(n = 1)
		if(n > @history.length)
			return nil
		else
			@contents = @history[-n]
			@history = @history.take(@history.length - n)
			@modified = Time.now
			return @contents
		end
	end
end

class Directory
	def initialize()
		@children = Hash.new
	end
	
	def store(name, child)
		@children[name] = child
	end
	
	def get(name)
		@children[name]
	end
	
	def delete(name)
		@children.delete(name)
	end
	
	def size()
		size = 0
		@children.each {|k, v| 	size += v.size()}
		size
	end
	
	def undo(n)
		@children.each {|k, v| v.undo(n)}
	end
	
	def get_by_path(path)
		gbp_helper(path.split("/"), 0)
	end
	
	protected
	def gbp_helper(path_arr, index)
		if(index >= path_arr.length)
			return nil
		else
			d = @children[path_arr[index]]
			if(d.nil?)
				return nil
			elsif(d.is_a? Directory)
				return d.gbp_helper(path_arr, index + 1)
			elsif(index == path_arr.length - 1)
				return d
			else
				return nil
			end
		end
	end
end