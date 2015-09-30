json.restaurants @mymaps do |mymap|
	restaurant = mymap.restaurant

	json.id restaurant.id
	json.name restaurant.name
	json.lat restaurant.lat
	json.lng restaurant.lng

	json.mymap do
		json.id mymap.id
		json.group mymap.group
		json.rating mymap.rating
		json.contents mymap.contents
	end
end
