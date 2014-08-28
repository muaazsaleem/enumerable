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

my_each [1,2,3] {|c| puts c}
my_each ({"one" => "uno",
"two" => "dos",
"three" => "tres"}) {|key, value| puts "#{key}: #{value}"}

my_each_with_index [1,2,3] {|c,i| puts "#{c} : #{i}"}

my_each ({"one" => "uno",
"two" => "dos",
"three" => "tres"}) {|key, value, i| puts "#{i.to_s} - #{key}: #{value}"}