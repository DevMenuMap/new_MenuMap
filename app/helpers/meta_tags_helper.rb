module MetaTagsHelper
	### Meta Title tags
	def meta_title(page_title = '')
		if page_title.blank?
			"MenuMap || 온라인 메뉴제공 서비스 메뉴맵"
		else
			page_title + " || 온라인 메뉴제공 서비스 메뉴맵"
		end
	end

	# Each restaurants#show page specific meta title
	def restaurant_meta_title
		# if params[:action] == "show"
			title = "[" + @restaurant.subcategory.name + "] " 	# subcategory
			title += @restaurant.name + " - "										# name
			# title += @restaurant.title_addr + " "							# title_addr
			title	+= "배달가능" if @restaurant.delivery					# delivery
			title += " || MenuMap 온라인 메뉴제공 서비스"				# MenuMap
		# else
		# 	DEFAULT_META_TITLE
		# end			
	end


	### Meta Description tags
	# Each restaurants#show page specific meta description
	def restaurant_meta_description
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
