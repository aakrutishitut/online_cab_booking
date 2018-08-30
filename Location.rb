class Location
	Location_d=Struct.new(:x,:y)
	attr_accessor :x
	attr_accessor :y
	def initialize(x,y)
		@x=x
		@y=y
	end
	def distance(l1) # location of the cab is passed in argument
		return ((x-l1.x)*(x-l1.x)+(y-l1.y)*(y-l1.y))
	end
end
