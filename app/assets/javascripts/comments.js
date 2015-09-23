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

// Menu tags for comment
function autocompleteMenus(target) {
	$(target).tagit({
		autocomplete: {
			source: window.location.origin + '/restaurants/' + $(target).data('restaurant').toString() + '/menu_complete.json' + '?term=' + $(target).val()
		},
		placeholderText: "#메뉴_이름_태그"
	});
};


$(document).on('ready page:load', function() {
	disableCommentPaste('#comment_contents');
	commentContentsValidation('#new_comment');
	autocompleteMenus('#new_comment .menu_comments_tag');
});
