function parseFoursquareImg(currentUrl){
	var jsonUrl = currentUrl + ".json"

	$.getJSON(jsonUrl, function(data){
		alert(data['name'] + data['addr']);
	});
};
