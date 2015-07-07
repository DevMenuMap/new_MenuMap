class Restaurant < ActiveRecord::Base
	### Mixins
	include Naver


	### Associations
  belongs_to :category
  belongs_to :subcategory

	has_one 	 :rest_info
	has_one 	 :coordinate,  as: :latlng

	has_many	 :rest_errs
	has_many	 :menu_titles
	has_many	 :menus, through: :menu_titles
	has_many 	 :comments
	has_many 	 :pictures, 		as: :imageable


	### Associated attributes
	accepts_nested_attributes_for :pictures

	
	### Validations
	validates :name, presence: true
	validates :addr, presence: true
	validates :category_id, presence: true
	validates :subcategory_id, presence: true

	
	### Scopes
	default_scope { where active: true }
	
	scope :in_area, -> (area) { where("addr LIKE ?", "%#{area}%") if area }


	### Class methods
	# Find restaurants which is not relevant with menu_on and menus related
	def self.menu_on_err(n)
		if n > 0
			# restaurants without any menu_titles(menu_title.without_menus can
			# check if all menu_titles have menus) but menu_on is bigger than 0.
			where("menu_on > 0 AND id NOT IN ( SELECT DISTINCT restaurant_id FROM menu_titles )")
		else
			# restaurants which have menus but menu_on equals 0.
			where("menu_on = 0 AND id IN ( SELECT DISTINCT restaurant_id FROM menu_titles )")
		end
	end

	# Find restaurants which has no associated rest_info and make one for
	# one to one association.
	def self.create_rest_infos(log_file)
		self.where("id NOT IN (SELECT DISTINCT(restaurant_id) FROM rest_infos)").each do |restaurant|
			if restaurant.create_rest_info(id: restaurant.id)
				log_file.puts "Succeed in making rest_info id: #{restaurant.id}"
			else
				log_file.puts "***** Fail restaurant id: #{restaurant.id}"
			end
		end
	end

	# Find Restaurant without one of the coordinates
	def self.without_latlng
		self.where("id NOT IN ( SELECT latlng_id FROM coordinates WHERE latlng_type = ? AND lat IS NOT NULL AND lng IS NOT NULL)", "Restaurant")
	end

	# Save Naver's coordinates to restaurant's nested attributes(coordinate
	# model) based on that area.
	def self.save_latlngs(area = nil, log_file)
		log_file.puts "Check if there is restaurants without rest_info"
		create_rest_infos(log_file)

		log_file.puts "Get coordinates from Naver and save them on restaurants"
		# Naver only gets 100,000 requests daily for one API key.
		self.in_area(area).without_latlng.take(100000).each do |restaurant|
			latlng = restaurant.get_latlng
			log_file.puts "Get Naver's latitude: #{latlng[0]} and longitude: #{latlng[1]}"

			restaurant.save_latlng(latlng, log_file)
		end
	end


	### Instance methods
	# restaurant's coordinate from Naver
	def lat
		coordinate ? coordinate.lat : nil
	end

	def lng
		coordinate ? coordinate.lng : nil
	end

	# Get Google's coordinate for restaurant
	def g_lat
		rest_info.coordinate ? rest_info.coordinate.lat : nil
	end

	def g_lng
		rest_info.coordinate ? rest_info.coordinate.lng : nil
	end

	def save_latlng(latlng, log_file)
		if valid_latlng?(latlng)
			create_coordinate(lat: latlng[0], lng: latlng[1])
			log_file.puts "Saved restaurant #{self.id}'s latlng(Naver)"
		else
			log_file.puts "***** Fail restaurant #{self.id}"	
		end		
	end

	# Get Naver's coordinate and save it into this instance instantly
	def get_and_save_latlng
		latlng = get_latlng
		create_coordinate(lat: latlng[0], lng: latlng[1])
	end
end
