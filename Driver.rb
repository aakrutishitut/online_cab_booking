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