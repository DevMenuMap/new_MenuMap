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
	has_many 	 :addr_tags


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
	# Find restaurants with user's query
	def self.search(delivery = nil, category = nil, name = nil, addr = nil)
		search_by_delivery(delivery).search_by_category(category).search_by_name(name).search_by_addr(addr)
	end

	def self.search_by_delivery(delivery)
		if delivery.to_i == 1
			where("delivery = ?", 1)	
		else
			all
		end
	end

	def self.search_by_category(category)
		range = Subcategory.range(category)
		where("subcategory_id >= ? AND subcategory_id < ?", range[:min], range[:max])
	end

	def self.search_by_name(name)
		# Split the name query and find all restaurants which name includes 
		# all queries.
		if name.present?
			sql = []
			# () automatically changes into \s.(why?)
			name.gsub!(/[,.;:'"-_&]/, ' ')
			name.split.each do |s|
				sql << "name LIKE '%#{s}%'"	
			end
			where(sql.join(" AND "))
		else
			all
		end
	end

	def self.search_by_addr(addr)
		if addr.present?
			# Search unique addresses with addr query return addr_hash
			address_id_array = convert_addr_to_unique_address_ids(addr)

			# Return empty activerecord relation []
			return Restaurant.none if address_id_array.blank?

			# Return addr_hash based on district category. 
			# {:addr_tag, :si, :gu, :gu_2, :legal_dong, :admin_dong}
			address_hash = address_range_hash(address_id_array)

			# addr_sql_query returns real query statement for searching by addr.
			where(addr_sql_query(address_hash))
		else
			all
		end
	end

	# Find restaurants which is not relevant with menu_on and menus related
	def self.menu_on_err(n)
		if n > 0 
			# restaurants without any menu_titles(menu_title.without_menus can
			# check if all menu_titles have menus) but menu_on is bigger than 0.
			joins("LEFT JOIN menu_titles ON restaurants.id = menu_titles.restaurant_id").where("menu_on > 0 AND menu_titles.id IS NULL")
		else
			# restaurants which have menus but menu_on equals 0.
			# It needs distinct option because join table will return duplicate 
			# restaurants.
			distinct.joins("LEFT JOIN menu_titles ON restaurants.id = menu_titles.restaurant_id").where("menu_on = 0 AND menu_titles.id IS NOT NULL")
		end
	end

	# Find restaurants which has no associated rest_info and make one for
	# one to one association.
	def self.create_rest_infos(log_file)
		joins("LEFT JOIN rest_infos ON restaurants.id = rest_infos.id").where("rest_infos.id IS NULL").each do |restaurant|
			if restaurant.create_rest_info(id: restaurant.id)
				log_file.puts "Succeed in making rest_info id: #{restaurant.id}"
			else
				log_file.puts "***** Fail restaurant id: #{restaurant.id}"
			end
		end
	end

	# Find Restaurant with Naver's coordinate.
	def self.with_latlng
		joins("LEFT JOIN coordinates ON restaurants.id = coordinates.latlng_id AND coordinates.latlng_type = 'Restaurant'").where("coordinates.id IS NOT NULL")
	end
	
	# Find Restaurant without Naver's coordinate.
	def self.without_latlng
		joins("LEFT JOIN coordinates ON restaurants.id = coordinates.latlng_id AND coordinates.latlng_type = 'Restaurant'").where("coordinates.id IS NULL")
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

	# If a restaurant has Naver's coordinate.
	def with_latlng?
		coordinate.present?
	end

	# Find most recent menus updated_at
	def menus_updated_at
		menus.select(:updated_at).limit(1).order("updated_at DESC").first.updated_at
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

	# Best menus with name, side_info and price for meta description.
	# Arguments n defines the number of outputs. 
	def title_menus_and_prices(n)
		title_menus = []
		menus.order(best: :desc, id: :asc).limit(n).each do |m|
			if m.side_info
				title_menus << ( m.name + m.side_info + " " + m.price_in_won )
			else
				title_menus << ( m.name + " " + m.price_in_won )
			end
		end
		title_menus.join(", ")
	end

	# Short version of best menus with only name and side_info.
	def title_menus(n)
		title_menus = []
		menus.order(best: :desc, id: :asc).limit(n).each do |m|
			title_menus << ( m.name + m.side_info )
		end
		title_menus.join(", ")
	end

	# If restaurant's address is changed, delete addr_code, addr_tags and
	# coordinates and update addr_updated_at.
	def destroy_related_when_addr_updated(params)
		if addr != params[:restaurant][:addr]
			update(addr_code: nil)
			# addr_tags.destroy_all
			coordinate.destroy						if coordinate.present?
			rest_info.coordinate.destroy	if rest_info.coordinate.present?
			rest_info.update(addr_updated_at: Time.now)
		end
	end

	### Private Class methods
	class << self

	private

		def convert_addr_to_unique_address_ids(addr)
			AddrConversion.where("'#{addr}' LIKE CONCAT('%', convert_from, '%')").distinct.pluck(:address_id)
		end

		# Return hash for address_id's ranges for each district.
		def address_range_hash(addr_array)
			# :gu_2 exists just for matching the numbers.
			addr_hash = { addr_tag: [], si: [], gu: [], gu_2: [], 
										legal_dong: [], admin_dong: [] }
			addr_array.each do |id|
				if id > 10**11					# :addr_tag
					n = 0
				elsif id % 10**9 == 0		# :si
					n = 1
				elsif id % 10**7 == 0		# :gu
					n = 2
				elsif id % 10**3 == 0		# :legal_dong
					n = 4 
				else										# :admin_dong	
					n = 5 								
				end

				# Key for addr_hash
				key = addr_hash.keys[n]
				if n == 0
					addr_hash[key] << id
				elsif n < 3
					addr_hash[key] << { min: id, max: id + 10**(11 - 2*n) }
				elsif n > 3
					# Divider for not subordinate dongs.
					divider = 16 - 3*n
					# When it is not subordinate dong. e.g. 신림동(o), 신림3동(x)
					if id % 10**divider == 0
						addr_hash[key] << { min: id, max: id + 10**divider }
					# When it is subordinate dong. e.g. 대치2동, 개포1동
					else							 
						addr_hash[key] << { min: id, max: id + 10**(divider - 1) }
					end
				end
			end

			addr_hash
		end
	
		# Return sql query statement for searching by address.
		# addr_hash = { :addr_tag, :si, :gu, :gu_2, :legal_dong, :admin_dong }
		def addr_sql_query(addr_hash)
			sql = { addr_tag: [], si: [], gu: [], legal_dong: [], admin_dong: [] }
			addr_hash.each_key do |key|
				# if addr_hash[key].present?
				if addr_hash[key].present? && key != :addr_tag
						
					temp = []
					addr_hash[key].each do |range|
						# if key == :addr_tag
							# temp << "id IN (SELECT DISTINCT addr_tags.restaurant_id 
							# FROM addr_tags WHERE addr_tags.address_id = #{n})"
						# elsif key != :admin_dong
						if key != :admin_dong
							temp << "( addr_code >= #{range[:min]} AND addr_code < #{range[:max]} )"
						else
							admin =  "MOD(addr_code, 1000) >= #{range[:min] % 1000} AND "
							admin += "MOD(addr_code, 1000) <  #{range[:max] % 1000} AND "
							admin += "(addr_code div POW(10,6))	= #{range[:min] / 10**6}"
							temp << ( "(" + admin + ")" )
						end
					end
					
					sql[key] = "(" + temp.join(" OR ") + ")"
				end
			end

			temp = []
			sql.each do |key, value|
				if key != :legal_dong && key != :admin_dong
					temp << value
				end
			end
			temp.flatten!
			
			sql_query = ""
			if temp.present?
				temp.map{ |q| sql_query += q + " AND " }
			end
			if sql[:legal_dong].present? && sql[:admin_dong].present?
				sql_query += "(" + sql[:legal_dong] + " OR " + sql[:admin_dong] + ")"
			elsif sql[:legal_dong].present? 
				sql_query += sql[:legal_dong]
			elsif sql[:admin_dong].present?
				sql_query += sql[:admin_dong]
			else
				sql_query.gsub!(/\sAND\s$/, '')
			end
			sql_query
		end
	end
end
