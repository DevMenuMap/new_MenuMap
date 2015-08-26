$(document).on('ready page:load', function() {
	$('#new_comment').validate({
		rules: {
			'comment[contents]': { required: true }
		}
	});

	$('#comment_contents').bind("paste", function(e) {
		alert("붙여넣기는 금지되어 있습니다.");
		e.preventDefault(); 
	});
});
