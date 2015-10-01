class Mymap < ActiveRecord::Base
	### Associations
  belongs_to :restaurant
  belongs_to :user

	
	### Validations
	validates :restaurant, presence: true
	validates :user, 			 presence: true
	# rating = 0..10
	validates :rating, numericality: { only_integer: true,
																		 greater_than_or_equal_to: 0,
																		 less_than_or_equal_to:		 10 },
										 allow_nil: true,
										 allow_blank: true
	validates :contents, length: { maximum: 255 }
	
	# Custom validations
	validate  :no_slang


	### Instance methods
  def no_slang
    if Slang.where("? LIKE CONCAT('%', name, '%')", contents).present?
      errors.add(:contents, "Slang")
    end
  end

	def index_plus_one
		user.mymaps.index(self) + 1
	end
end
