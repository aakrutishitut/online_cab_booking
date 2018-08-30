require './Location.rb'
require './Person.rb'
require './Customer.rb'
require './Car.rb'
require './Driver.rb'
require './Bookings.rb'
require './Display.rb'
class System
	Location_d=Struct.new(:x,:y)
	Car_d=Struct.new(:car_number,:car_color,:car_type)
	Driver_d=Struct.new(:id,:name,:mobile_no)
	Bookings_d=Struct.new(:id,:source,:destination,:fare)
	Customer_d=Struct.new(:id,:name,:mobile_no)
	include MyModule
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
		drivers<<temp #add to list of drivers
		free_cabs[temp.location]=temp #add to the available cabs 
	end
	def display_customers
		for i in 0...customers.length
				tem_b=nil
				puts customers[i].booking.driver
				#tem_c=Car_d.new(customers[i].booking.driver.car.car_no,customers[i].booking.driver.car.color,customers[i].booking.driver.car.car_type)
				temp_d=Driver_d.new(customers[i].booking.driver.id,customers[i].booking.driver.name,customers[i].booking.driver.mobile_no)
				temp_d_1=temp_d.to_h
				tem_b=Bookings_d.new(customers[i].booking.id,customers[i].booking.source,customers[i].booking.destination,customers[i].booking.fare)
				tem_b_1=tem_b.to_h
				tem=Customer_d.new(customers[i].id,customers[i].name,customers[i].mobile_no)
				tem1=tem.to_h
				customers[i].disp(tem1)
				puts "Booking"
				customers[i].disp(tem_b_1)
				puts "Driver Details"
				customers[i].disp(temp_d_1)
				#puts "Name:#{customers[i].name}\nMobile_no:#{customers[i].mobile_no}"
				puts "\n"
		end
	end
	def display_drivers
		for i in 0...drivers.length
			drivers[i].display
			temp_d=Driver_d.new(drivers[i].id,drivers[i].name,drivers[i].mobile_no)
			tem=temp_d.to_h
			drivers[i].disp(tem)
			puts "\n"
		end
	end
	def display_free_cabs
		free_cabs.each{|key,value|	puts value.display} #displays drivers and cabs which are free 
	end
	def book_ride
		puts "Enter customer id"
		c=customers[gets.chomp.to_i]
		puts "Enter source"
		i=Location.new(gets.chomp.to_i,gets.chomp.to_i)
		puts "Enter destination"
		f=Location.new(gets.chomp.to_i,gets.chomp.to_i)
		temp=Bookings.new(@@booking_id,i,f)
		
		ans="none"
		ans=temp.find_cab(free_cabs) #finds nearest cabs
		if ans=='none'
			puts "No cabs available"
		else
			temp.driver=ans
			c.add_booking(temp)
			bookings[@@booking_id]=ans #add driver to the bookings hash with key as booking id
			puts "Your booking id:"
			puts @@booking_id
			puts "Driver details"
			puts ans.display
			@@booking_id+=1
			free_cabs.delete(ans.location) #remove the booked cab from free_cabs
		end
	end
	def cancel_ride
		puts "Enter customer id"
		c=gets.chomp.to_i
		b=customers[c].return_booking_id #returnds booking id of current booking of the customer
		customers[c].remove_booking #removes the booking of the customer
		temp= bookings[b]	
		free_cabs[temp.location]=temp	#add the driver back to the free_cabs
	end
	def start
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