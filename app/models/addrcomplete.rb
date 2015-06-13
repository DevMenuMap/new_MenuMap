class Addrcomplete < ActiveRecord::Base
	validates :name, uniqueness: true
end
