json.mymaps @mymaps do |mymap|
	restaurant = mymap.restaurant

	json.id restaurant.id
	json.name restaurant.name
	json.lat restaurant.lat
	json.lng restaurant.lng
	json.mymapGroup mymap.group
end
