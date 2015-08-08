function slangCheck(formRoute, textRoute) {
	$( formRoute ).submit( function(event) {
		var url = window.location.origin + '/home/slang';
		var result;
		$.ajax({
			async: false,
			url: url,
			data: {
				contents: $( textRoute ).val()
			},
			success: function( data ) {
				result = !(data.status);
			}
		});
		// if slang exists, result = false
		return result;
	});
};
