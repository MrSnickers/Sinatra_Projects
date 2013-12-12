class Cat
	attr_accessor :name, :color

	NAMES = ["cheeto", "aurelia", "zak", "hadoop", "ginger", "gorby", "seatac"]
	COLORS = ["orange", "tortoise shell", "black", "grey"]

	def initialize 
		@name = NAMES.sample
		@color = COLORS.sample
	end
end