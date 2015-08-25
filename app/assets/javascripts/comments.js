$(document).ready( function() {
	$('#new_comment').validate({
		rules: {
			'comment[contents]': { required: true }
		}
	});

	$('#comment_contents').bind("paste", function(e) {
		alert("붙여넣기는 금지되어 있습니다.");
		e.preventDefault(); 
	});

	$('#update_comment').click( function(e) {
		if ( <%= current_user.nil? %> ) {
			alert("로그인 후 댓글 작성 가능합니다.");
			e.preventDefault();
		};
	});
});
