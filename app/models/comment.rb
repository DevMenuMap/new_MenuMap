class Comment < ActiveRecord::Base
	### Associations
  belongs_to :user
  belongs_to :restaurant

  # has_many :menu_comments
  has_many :pictures, as: :imageable
  has_many :menu_comments
  has_many :menus, through: :menu_comments


  ### Validations
  validates :user, presence: true
  validates :restaurant, presence: true
  validates :contents, presence: true, 
											 length: { maximum: 255,
  															 too_long: "%{count} characters is the maximum allowed" }

  # Custom validators
  validate :no_slang


  ### Scopes
  default_scope { where(active: true) }
  default_scope { order(created_at: :desc) }


  ### Instance methods
  def no_slang
    if Slang.where("? LIKE CONCAT('%', name, '%')", contents).present?
      errors.add(:contents, "Slang")
    end
  end
end
