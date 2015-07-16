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
end
