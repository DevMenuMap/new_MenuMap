class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	# Facebook
	devise :omniauthable, omniauth_providers: [:facebook]


	### Constants
	USERNAME_FORMAT = /\A[a-zA-Z\p{Hangul}][a-zA-Z0-9_\-\p{Hangul}]+\z/
  USERNAME_CONSTRAINTS = ['메뉴맵', '매뉴맵', '메뉴멥', '메뉴맵', 
													'MenuMap', '운영자', 'admin', 'root', '사장님']
	EMAIL_FORMAT = /\A(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Z‌​a-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}\z/i


	### Attributes
	attr_accessor :skip_username_constraints

	### Associations
	has_one :mymap_snapshot

	has_many :questions
	has_many :rest_registers
	has_many :rest_errs
	has_many :menus
	has_many :comments
	has_many :mymaps
	has_many :restaurants, through: :mymaps


	### Validations
	validates :username, presence: true, uniqueness: { case_sensitive: false },
											 format: { with: USERNAME_FORMAT, message: '유저명은 한글, 영어, 숫자, -, _ 으로만 가능합니다.' }, 
											 length: { maximum: 20 }
	validates :email, format: { with: EMAIL_FORMAT, message: "이메일 형식이 잘못되었습니다." }

	# Custom validators
	validate :no_slang
	validate :no_particular_word, unless: :skip_username_constraints
	validate :size_in_byte

	
	### Scopes
	default_scope { where(active: true) }

	### Class methods
	# Facebook login
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.password = Devise.friendly_token[0,20]
			user.username = "fb_" + auth.uid
			if auth.info.email.nil?
				user.email = "fb_" + auth.uid + "@menumap.co.kr" 
			else
				user.email = auth.info.email
			end
			user.fb_img = auth.info.image 
			user.confirmed_at = Time.now
			# user.skip_confirmation_notification!
		end
	end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


	### Instance method
	def no_slang
    if Slang.where("? LIKE CONCAT('%', name, '%')", username).present?
      errors.add(:username, "유저명에 비속어를 포함할 수 없습니다.")
    end
  end

  def no_particular_word
  	username_downcase = username.downcase

		USERNAME_CONSTRAINTS.each do |constraint|
			if username_downcase.include? constraint.downcase
				errors.add(:username, "#{constraint}는 유저명에 들어갈 수 없는 단어입니다.")
				return
			end
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
