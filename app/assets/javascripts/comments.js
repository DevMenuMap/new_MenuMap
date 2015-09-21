function disableCommentPaste(target) {
	$(target).bind("paste", function(e) {
		alert("붙여넣기는 금지되어 있습니다.");
		e.preventDefault(); 
	});
};

function commentContentsValidation(target) {
	$(target).validate({
		rules: {
			'comment[contents]' : { 
				required: true,
				maxlength: 255
			}
		},
		messages: {
			'comment[contents]' : { 
				required: '댓글 내용을 적어주세요.',
				maxlength: '255자 이내로 적어주세요.'
			}
		}
	});
};

$(document).on('ready page:load', function() {
	disableCommentPaste('#comment_contents');
	commentContentsValidation('#new_comment');
});
