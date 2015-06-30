class Question < ActiveRecord::Base
	validates :contents, presence: true
	belongs_to :user
end
