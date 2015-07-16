// Get Foursquare images by parsing.
function parseFoursquareImg(currentUrl){
	var jsonUrl = currentUrl + ".json"

	$.getJSON(jsonUrl, function(restaurantData){
		$.ajax({
			url: "/foursquares/parse",
			data: {
				name: restaurantData.name,
				lat:  restaurantData.lat,
				lng:  restaurantData.lng,
			}
		});
	});
};
