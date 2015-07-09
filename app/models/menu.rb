class Menu < ActiveRecord::Base
	### Mixins
	include ActionView::Helpers::NumberHelper

			
	### Associations
	belongs_to :menu_title
	belongs_to :user

  has_many :menu_comments
  has_many :comments, through: :menu_comments


	### Validations
	validates :menu_title, presence: true
	validates :name, presence: true
	validates :price, numericality: { only_integer: true,
																		greater_than: 0,
																		# Price should be less than 10 million.
																		less_than:		10000000 },
										allow_nil: true,
										allow_blank: true,
										# Check if price is divisible by 10.
										format: { with: /0\z/ }
	
	# Custom validators
	validate :no_price_when_unidentified_is_true


	### Scopes
	default_scope { where(active: true) }


	### Instance methods
	# Custom validator methods
	# When a user doesn't know menu's price, he can set unidentified true
	# and not price value nor sitga true.
	def no_price_when_unidentified_is_true
		if unidentified && ( price.present? || sitga )
			errors.add(:unidentified, "no price when unidentified")
		end
	end

	def price_in_won
		number_with_delimiter(self.price).to_s + "원"
	end
end
