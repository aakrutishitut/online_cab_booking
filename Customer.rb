require './Display.rb'
class Customer<Person
	include MyModule
		attr_accessor :booking
	def initialize(id,name,mobile_no,location)
		@booking=nil
		super
	end
	def add_booking(booking) # adds current booking to the 
		@booking=booking
	end
	def remove_booking # remove the booking when ride is ended and cancelled
		@booking=nil
	end
	def return_booking_id # returns the id of current booking
		return booking.id
	end
	def display 
		super
	end
end