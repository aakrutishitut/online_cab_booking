class Location
	attr_accessor :x
	attr_accessor :y
	def initialize(x,y)
		@x=x
		@y=y
	end
	def distance(l1)
		return ((x-l1.x)*(x-l1.x)+(y-l1.y)*(y-l1.y))
	end
end

class Person 
	attr_accessor :location
	def initialize(id,name,mobile_no,location)
		@id=id
		@name=name
		@mobile_no=mobile_no
		@location=location
	end
	def update_location(location)
		@location=location
	end
	def display
		puts "Name:"
		puts @name
		puts "Mobile no:"
		puts @mobile_no

	end
end
class Customer<Person
	def initialize(id,name,mobile_no,location)
		super
	end
	def display 
		super
	end
end
class Driver<Person
	attr_accessor :car
	def initialize(id,name,mobile_no,location,car)
		super(id,name,mobile_no,location)
		@car=car
	end
	def display 
		super
		puts "Car number:"
		puts car.car_no
		puts "Car type:"
		puts car.car_type
		puts "Car color:"
		puts car.color


	end
end
class Car
	attr_accessor :car_no
	attr_accessor :car_type
	attr_accessor :color
	def initialize(car_no,car_type,color)
		@car_no=car_no
		@car_type=car_type
		@color=color
	end
end
class Bookings 
	attr_accessor :driver
	attr_accessor :source
	def initialize(id,customer,source,destination)
		@id=id
		@customer=customer
		@driver=0
		@fare=calculate_fare(source,destination)
		@source=source
		@destination=destination
	end
	def calculate_fare(s,d)
		x=Math.sqrt(2 **(s.x-d.x)+ 2 **(s.y-d.y))
		puts "Estimated fare:"
		puts x*11
	end
	def find_cab(free_cabs)
		arr=free_cabs.keys
		min=10000000
		ans="none"
		z=1
		for i in 0...arr.length
			z=source.distance(arr[i])
			#puts z
			#puts free_cabs[arr[i]]
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
class System
	attr_accessor :customers
	attr_accessor :drivers
	attr_accessor :bookings
	attr_accessor :free_cabs
	@@cust_id=0
	@@driver_id=0
	@@booking_id=0
	def initialize
		@customers=[]
		@drivers=[]
		@bookings={}
		@free_cabs={}

	end
	def add_new_customer
		puts "Enter name"
		name=gets.chomp.to_s
		puts "Enter mobile number"
		mob=gets.chomp.to_i
		puts "Enter location"
		loc=Location.new(gets.chomp.to_i,gets.chomp.to_i)
		c=Customer.new(@@cust_id,name,mob,loc)
		puts "Your customer id :"
		puts @@cust_id
		@@cust_id+=1
		customers<<c
	end
	def add_new_driver
		puts "Enter name"
		name=gets.chomp.to_s
		puts "Enter mobile number"
		mob=gets.chomp.to_i
		puts "Enter location"
		loc=Location.new(gets.chomp.to_i,gets.chomp.to_i)
		puts "Enter car number"
		num=gets.chomp.to_s
		puts "Enter color of car "
		color=gets.chomp.to_s
		puts "Enter type of car(mini,micro,suv)"
		type=gets.chomp.to_s
		temp=Driver.new(@@driver_id,name,mob,loc,Car.new(num,color,type))
		puts "Your driver id :"
		puts @@driver_id
		@@driver_id+=1
		drivers<<temp
		free_cabs[temp.location]=temp
	end
	def display_customers
		for i in 0..customers.length
			customers[i].display
			puts "\n"
		end
	end
	def display_drivers
		for i in 0..drivers.length
			drivers[i].display
			puts "\n"
		end
	end
	def display_free_cabs
		free_cabs.each{|key,value|	puts key.x}
	end
	def book_ride
		puts "Enter customer id"
		c=customers[gets.chomp.to_i]
		puts "Enter source"
		i=Location.new(gets.chomp.to_i,gets.chomp.to_i)
		puts "Enter destination"
		f=Location.new(gets.chomp.to_i,gets.chomp.to_i)
		temp=Bookings.new(@@booking_id,c,i,f)
		ans="none"
		ans=temp.find_cab(free_cabs)
		if ans=='none'
			puts "No cabs available"
		else
			bookings[@@booking_id]=ans
			puts "Your booking id:"
			puts @@booking_id
			puts "Driver details"
			puts ans.display
			@@booking_id+=1
			free_cabs.delete(ans.location)
		end
	end
	def cancel_ride
		puts "Enter booking id"
		temp= bookings[gets.chomp.to_i]
		#temp.display 
		free_cabs[temp.location]=temp
	end
	def start
		a=1
		while a.to_s!="end"
			puts "Choose amoungst following options 
				 1.Add new customer
				 2.Add new driver
				 3.Book Ride
				 4.Cancel Ride
				 5.End Ride
				 6.Display Customers
				 7.Display Drivers
				 8.Display free cabs
				 "
				 a=gets.chomp
				 case a.to_i
				 when 1
				 	add_new_customer
				when 2
					add_new_driver
				when 3
					book_ride
				when 4
					cancel_ride
				when 5
					cancel_ride
				when 6
					display_customers
				when 7
					display_drivers
				when 8
					display_free_cabs
				else
					a="end"
				end
		end
	end
end
s=System.new
s.start