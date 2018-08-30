require './Driver.rb'
class Bookings 
	attr_accessor :driver
	attr_accessor :source
	attr_accessor :id, :destination, :fare
	def initialize(id,source,destination)
		@id=id
		@driver=nil
		@fare=calculate_fare(source,destination)
		@source=source
		@destination=destination
	end
	def calculate_fare(s,d) #source and destination is passed to calculate distance and fare
		x=Math.sqrt(2 **(s.x-d.x)+ 2 **(s.y-d.y))
		puts "Estimated fare:"
		puts x*11
		return x*11
	end
	def find_cab(free_cabs) #finds the nearest cab from source
		arr=free_cabs.keys
		min=10000000
		ans="none"
		z=1
		for i in 0...arr.length
			z=source.distance(arr[i])
			if(z<min)
				min=z
				ans=free_cabs[arr[i]]
			end 
		end
		puts ans.display
		driver=ans
		return ans
	end

end