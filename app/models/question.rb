class Question < ActiveRecord::Base
	belongs_to :user
	validates :contents, presence: true
	default_scope { where(active: true) }
end
