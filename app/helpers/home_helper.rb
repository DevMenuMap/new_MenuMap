module HomeHelper
	def total_restaurants
		number_with_delimiter(Restaurant.count)
	end

	def total_restaurants_with_menu
		number_with_delimiter(Restaurant.where("menu_on > 0").count)
	end

	def total_menus
		number_with_delimiter(Menu.count)
	end
end
