class Question < ActiveRecord::Base
	validates :contents, presence: true
end
