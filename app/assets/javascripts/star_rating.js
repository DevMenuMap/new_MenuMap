$(document).on('ready page:load', function() {
	// Show star rating for comments.
	$(".star_rating").raty({
		path: "/images/star_rating/",
		readOnly: true,
		score: function() { return parseInt($(this).attr("data-score")) / 2 }
	});
});
