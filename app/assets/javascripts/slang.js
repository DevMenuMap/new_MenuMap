function slangCheck(formRoute, textRoute) {
	$( formRoute ).submit( function(event) {
		var url = window.location.origin + '/home/slang';
		$.ajax({
			url: url,
			data: {
				contents: $( textRoute ).val()
			},
			success: function( data ) {
				if (data.status) {
					alert(data.slang + "은(는) 금지된 단어입니다.");
				}; 
			}
		});
	});
};
