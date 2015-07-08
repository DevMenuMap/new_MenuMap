class Menu < ActiveRecord::Base
	### Associations
  belongs_to :menu_title
  belongs_to :user

  has_many :menu_comments
  has_many :comments, through: :menu_comments


  ### Validations
  # validates :menu_title, presence: true
  validates :name, presence: true
  validates :price, presence: true
  	

  ### Scopes
  default_scope { where(active: true) }
end
