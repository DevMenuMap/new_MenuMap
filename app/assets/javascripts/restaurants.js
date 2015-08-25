$(document).ready( function() {
	$("#carousel .item:first-of-type").addClass("active")

	// Prevent slangs.
	slangCheck("#new_comment", "#comment_contents");
});
