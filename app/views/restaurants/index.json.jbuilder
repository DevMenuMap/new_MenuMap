json.restaurants @restaurants do |restaurant|
	json.id restaurant.id
	json.name restaurant.name
	json.lat restaurant.lat
	json.lng restaurant.lng

	json.mymap do
		json.id 'none'
		json.group 'none'
	end
end
