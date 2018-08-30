require './Display.rb'
class Person 
	include MyModule
	attr_accessor :location, :id ,:name, :mobile_no
	def initialize(id,name,mobile_no,location)
		@id=id
		@name=name
		@mobile_no=mobile_no
		@location=location
	end
	def update_location(location)#when current location is changed 
		@location=location
	end
	def display
		puts "Name:"
		puts @name
		puts "Mobile no:"
		puts @mobile_no

	end
end