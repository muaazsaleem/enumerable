module MyEnumerable
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



	def my_select collection
		container = collection.class.new
		my_each(collection) do |key, value|
			if yield(key,value)
				container.push key if container.class == Array
				container[key] = value if container.class == Hash
			end
		end
		container
	end

	def my_all? collection
		bool = true
		
		my_each(collection) do |key, value|
			if  !yield(key,value)
				bool = false
			end
		end
		bool
	end

	def my_none? collection
		bool = true
		
		my_each(collection) do |key, value|
			if  yield(key,value)
				bool = false
			end
		end
		bool
	end

	def my_count (collection)
		count = 0
		
		my_each(collection) do |key, value|
			if  yield(key,value)
				count+=1
			end
		end
		count
	end

	def my_map collection
		container = collection.class.new
		my_each(collection) do |key, value|
			if yield(key,value)
				container.push yield(key,value) if container.class == Array
				container[key] = yield(key,value) if container.class == Hash
			end
		end
		container
	end

	def my_inject collection, initial_value
		temp = initial_value
		my_each(collection) do |key, value|
			yield_result = yield(temp, key, value)
			if yield_result
				temp =  yield_result 
			end
		end
		temp
	end
end





include MyEnumerable
array = [1,2,3]
hash = {"one" => "uno", "two" => "dos", "three" => "tres"}
my_each(array) {|c| puts c}
my_each (hash) {|key, value| puts "#{key}: #{value}"}

my_each_with_index(array) {|c,i| puts "#{c} : #{i}"}

my_each_with_index(hash) {|key, value, i| 
	puts "#{i.to_s} - #{key}: #{value}"}

p my_select(array) { |i| i%2 == 0 }
p my_select(hash) {|k,v| k== "two" }

p my_all?(array) { |i| i%2 == 0 }
p my_all?(hash) {|k,v| k== "two" }

p my_none?(array) { |i| i%2 == 0 }
p my_none?(hash) {|k,v| k== "two" }

p my_count(array) { |i| i%2 == 0 }
p my_count(hash) {|k,v| k== "two" }

p my_map(array){|num| num**2 }
p my_map(hash){|k,v| v+"yolo" }

p my_inject(array,1){|num,element| num*=element }

p my_inject(hash,0){|k,v| v.length }