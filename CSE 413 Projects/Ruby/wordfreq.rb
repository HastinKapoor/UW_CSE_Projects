
# Hastin Kapoor
# 2061247

count = Hash.new(0)
File.foreach(ARGV[0]) {|line| line.split.each {|str| count[str] += 1}}
result = count.sort_by {|key, value| key}
result.each {|key, value| puts key.to_s + " " + value.to_s}