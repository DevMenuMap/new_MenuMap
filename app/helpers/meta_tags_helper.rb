module MetaTagsHelper
	### Constants
	DEFAULT_META_TITLE = "MenuMap || 온라인 메뉴제공 서비스 메뉴맵"
	STATIC_META_TITLE	 = " || 온라인 메뉴제공 서비스 메뉴맵"


	### Meta Title tags
	def meta_title
		case params[:controller]
		when "home"
			home_meta_title
		# Notices, rest_registers are handled with static_meta_title
		when "notices"
			static_meta_title + STATIC_META_TITLE
		when "rest_registers"
			static_meta_title + STATIC_META_TITLE
		when /users/
			users_meta_title + STATIC_META_TITLE
		when "restaurants"
			restaurants_meta_title
		else
			DEFAULT_META_TITLE
		end
	end

	def home_meta_title
		if params[:action] == "brandpage"
			DEFAULT_META_TITLE
		else
			home_converter(params[:action]) + STATIC_META_TITLE
		end
	end

	def home_converter(action)
		case action
		when "about"
			"MenuMap 소개"
		when "manual"
			"MenuMap 매뉴얼"
		when "search"
			"음식점 검색"
		end		
	end

	def static_meta_title
		case params[:action]
		# notices#index
		when "index"
			"문의사항"
		# rest_registers#new
		when "new"
			"음식점 등록 신청"
		end
	end

	def users_meta_title
		case params[:controller]
		when /sessions/
			"로그인"
		when /registrations/
			"회원가입"
		end
	end

	def restaurants_meta_title
		if params[:action] == "show"
			title = "[" + @restaurant.subcategory.name + "] " 	# subcategory
			title += @restaurant.name + " - "										# name
			# title += @restaurant.title_addr + " "							# title_addr
			title	+= "배달가능" if @restaurant.delivery					# delivery
			title += " || MenuMap 온라인 메뉴제공 서비스"				# MenuMap
		else
			DEFAULT_META_TITLE
		end			
	end


	### Meta Description tags
	def meta_description
		if params[:controller] == "restaurants" && params[:action] == "show"
			restaurants_meta_description
		end
	end

	def restaurants_meta_description
		description	 = "음식점 #{@restaurant.name}("
		description	+= "#{@restaurant.category.name}) "
		# description =  "주요상권 및 위치: [#{additional_addr}] #{@restaurant.addr}"
		description += "주요상권 및 위치: #{@restaurant.addr}"

		# 4~5 menus would appear on meta description.
		if @restaurant.menus.present?
			description += ", 주요 메뉴의 메뉴판, 가격: " 
			description	+= "#{@restaurant.title_menus_and_prices(5)}"
		end

		if @restaurant.phnum
			if @restaurant.delivery
				description	+= ", 배달주문 전화번호: #{@restaurant.phnum}" 
			else
				description	+= ", 전화번호: #{@restaurant.phnum}" 
			end
		end
	end
end
