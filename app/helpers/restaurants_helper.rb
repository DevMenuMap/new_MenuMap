module RestaurantsHelper
	# Puts different states and links according to restaurant's menu_on. 
	def menu_on_helper(restaurant)
		if restaurant.menu_on == 0
			link_to "미등록", restaurant_path(restaurant, anchor: "new_menu_section")
		elsif restaurant.menu_on == 1
			link_to "등록중", restaurant_path(restaurant, anchor: "menu_section_top")
		else
			link_to "완전등록", restaurant_path(restaurant, anchor: "menu_section_top")
		end
	end

	# Restaurant's name with left border which has color for menu_on.
	def restaurant_name_with_menu_on(restaurant)
		color = menu_color(restaurant)
		content_tag :span, class: "name", style: "border-left: 4px solid #{color}" do
			" " + restaurant.name
		end
	end

	def menu_color(restaurant)
		case restaurant.menu_on
		when 1 
			"orange"
		when 0
			"gray"
		else
			"green"
		end
	end

	# Puts 2 title menus or subcategory name.
	def menus_or_category(restaurant)
		if restaurant.menus.blank?
			content_tag :span, restaurant.subcategory.name
		else
			content_tag :span, restaurant.title_menus(2).join(", ")
		end
	end

	# Puts string when delivery is possible.
	def delivery_possible?(restaurant)
		if restaurant.delivery
			content_tag :span, "배달", class: "label label-info"
		end
	end

	def delivery_possible_with_middot(restaurant)
		if restaurant.delivery
			content_tag :span, "&middot; 배달 가능".html_safe
		end
	end

	def gu_and_dong(restaurant)
		restaurant.addr.split[1..2].join(" ")
	end

	def restaurant_picture(restaurant)
		if picture = restaurant.pictures.first 
			image_tag picture.img.url(:small), alt: "#{restaurant.name} 사진", class: "thumbnail rst_img"
		else 
			image_tag "restaurants/default_restaurant.png", alt: "현재 등록된 사진이 없습니다.", class: "thumbnail rst_img"
		end 
	end
end
