class Comment < ActiveRecord::Base
	### Associations
  belongs_to :user
  belongs_to :restaurant

  # has_many :menu_comments
  has_many :pictures, as: :imageable
  has_many :menus, through: :menu_comments


  ### Validations
  # validates :user, presence: true
  validates :restaurant, presence: true
  validates :contents, presence: true, length: { maximum: 255,
  	too_long: "%{count} characters is the maximum allowed" }


  ### Scopes
  default_scope { where(active: true) }
end
