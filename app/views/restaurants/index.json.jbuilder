json.restaurants @restaurants do |restaurant|
	json.id restaurant.id
	json.name restaurant.name
	json.lat restaurant.lat
	json.lng restaurant.lng

	json.mymap do
		if current_user && current_user.saved_mymap?(restaurant)
			mymap = current_user.find_mymap(restaurant)

			json.id mymap.id
			json.group mymap.group
			json.rating mymap.rating
			json.contents mymap.contents
		else
			json.id 'none'
			json.group 'none'
		end
	end
end
