class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


	### Associations
	has_many :questions
	has_many :rest_registers
	has_many :rest_errs
	has_many :menus
	has_many :comments
	has_many :mymaps
	has_many :restaurants, through: :mymaps


	### Validations
	validates :username, presence: true, uniqueness: { case_sensitive: false },
											 format: {
											 	with: /\A[a-zA-Z_\p{Hangul}][a-zA-Z0-9_\p{Hangul}]+\z/,
											 	message: "invalid username"
											 }, length: { maximum: 20 }
	validates :email, format: {
										 with: /\A(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Z‌​a-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}\z/i,
										 message: "invalid email"
										}

	# Custom validators
	validate :no_slang
	validate :no_particular_word
	validate :size_in_byte


	### Instance method
	def no_slang
    if Slang.where("? LIKE CONCAT('%', name, '%')", username).present?
      errors.add(:username, "Slang")
    end
  end

  def no_particular_word
  	impossibles = ["메뉴맵", "menumap", "운영자", "profile", "store",
  								 "restaurant", "login", "logout", "signup", "signin",
  									"signout", "session", "user", "username", "test",
  									"help", "index", "home", "about", "contact", "root",
  									"manual", "delete", "destroy", "create", "make",
  									"show", "new", "post", "comment", "page", "invalid",
  									"valid"]
  	username_downcase = username.downcase
  	if username_downcase.end_with? "s"
  		username_downcase = username_downcase[0...-1]
  	end
  	if impossibles.include? username_downcase
  		errors.add(:username, "Impossible")
  	end
  end

  def size_in_byte
  	if username.bytesize < 6
  		errors.add(:username, "Too short")
  	end
  end

	def saved_mymap?(restaurant)
		find_mymap(restaurant).present?
	end

	def find_mymap(restaurant)
		mymaps.find_by(restaurant_id: restaurant.id)
	end
end
