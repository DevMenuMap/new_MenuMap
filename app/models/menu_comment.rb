class MenuComment < ActiveRecord::Base
	### Associations
  belongs_to :menu
  belongs_to :comment


	### Validations
	validates :menu, presence: true
	validates :comment, presence: true
end
