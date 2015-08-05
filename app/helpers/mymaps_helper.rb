module MymapsHelper
	# Determin mymap button to show mymap info or create a new mymap.
	def mymap_button(user, restaurant)
		if user && user.saved_mymap?(restaurant)
			show_mymap_info_button(user.find_mymap(restaurant))
		else
			new_mymap_button(user, restaurant)
		end
	end

	# Show MyMap information more with Ajax call to modal.
	def show_mymap_info_button(mymap)
		link_to "show_mymap_info", mymap_path(mymap.id), id: "show_mymap_#{mymap.id}", remote: true, data: {toggle: "modal", target: "#myModal"}
	end

	# Button to show modal for creating a new MyMap relationship.
	def new_mymap_button(user, restaurant)
		# Only when user exists, mymap#new modal can pop up.
		if user
			link_to "new mymap", new_restaurant_mymap_path(restaurant), id: "new_mymap_#{restaurant.id}", remote: true, data: {toggle: "modal", target: "#myModal"}
		else
			link_to "new mymap", "#", data: { confirm: "need login" }
		end
	end
end
