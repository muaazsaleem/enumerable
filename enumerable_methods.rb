module Enumerable
	def my_each collection
		
		if collection.class == Array
			collection.length.times do |i|
				yield collection[i]
			end
		elsif collection.class == Hash
			keys = collection.keys
			keys.size.times do |i|
				yield keys[i], collection[keys[i]]
			end
		end
	end

	def my_each_with_index collection

		if collection.class == Array
			collection.length.times do |i|
				yield collection[i],i
			end
		
		elsif collection.class == Hash
			keys = collection.keys
			keys.size.times do |i|
				key = keys[i]
				value = collection[keys[i]]
				
				yield(key, value, i)
			end
		end
		
	end

end
include Enumerable
array = [1,2,3]
hash = {"one" => "uno", "two" => "dos", "three" => "tres"}
my_each(array) {|c| puts c}
my_each (hash) {|key, value| puts "#{key}: #{value}"}

my_each_with_index(array) {|c,i| puts "#{c} : #{i}"}

my_each_with_index(hash) {|key, value, i| 
	puts "#{i.to_s} - #{key}: #{value}"}