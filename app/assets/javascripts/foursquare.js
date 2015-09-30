// Get Foursquare images by parsing.
function parseFoursquareImg(currentUrl){
	var jsonUrl = currentUrl + ".json"

	$.getJSON(jsonUrl, function(data){
		$.ajax({
			url: "/foursquares/parse",
			data: {
				name: data.restaurants[0].name,
				lat:  data.restaurants[0].lat,
				lng:  data.restaurants[0].lng
			}
		});
	});
};
