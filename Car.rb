class Car
	Car_d=Struct.new(:car_number,:car_color,:car_type)
	attr_accessor :car_no
	attr_accessor :car_type
	attr_accessor :color
	def initialize(car_no,car_type,color)
		@car_no=car_no
		@car_type=car_type
		@color=color
	end
end