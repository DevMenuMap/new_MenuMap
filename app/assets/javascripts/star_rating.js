// Show star rating for comments.
function showStarRating() {
	$(".star_rating").raty({
		path: "/images/star_rating/",
		readOnly: true,
		score: function() { return parseInt($(this).attr("data-score")) / 2 }
	});
};

// Star rating input.
function starRatingForm() {
	$(".star_rating_form").raty({
		path: "/images/star_rating/",
		half: true,
		scoreName: "comment[rating]",
		score: function() {
			return parseInt($(this).attr("data-score")) / 2;
		}
	});
};

$(document).on('ready page:load', function() {
	showStarRating();
	starRatingForm();
});
