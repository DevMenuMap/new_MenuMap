module MetaTagsHelper
	### Constants
	DEFAULT_META_TITLE = "MenuMap || 온라인 메뉴제공 서비스 메뉴맵"
	STATIC_META_TITLE	 = " || 온라인 메뉴제공 서비스 메뉴맵"


	### Meta Title tags
	def meta_title
		content_tag :title, case params[:controller]
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
end
