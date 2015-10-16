// Show star rating for comments.
function showStarRating() {
	$(".star_rating").raty({
		path: "/images/star_rating/",
		readOnly: true,
		score: function() { return parseInt($(this).attr("data-score")) / 2 }
	});
};

// Star rating input.
function starRatingForm(star) {
	if ( star == 'mymap' ) {
		var inputField = 'mymap[rating]';
	} else {
		var inputField = 'comment[rating]';
	};

	$(".star_rating_form").raty({
		path: "/images/star_rating/",
		half: true,
		scoreName: inputField,
		score: function() {
			return parseInt($(this).attr("data-score")) / 2;
		}
	});
};

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
				maxlength: 255,
				remote: { url: window.location.origin + '/home/validate_slangs' }
			}
		},
		messages: {
			'comment[contents]' : { 
				required: '댓글 내용을 적어주세요.',
				maxlength: '255자 이내로 적어주세요.',
				remote: '욕설이 들어갈 수 없습니다.'
			}
		}
	});
};

// Menu tags for comment
function autocompleteMenus(target) {
	if ( $(target).data('restaurant') > 0 ) {
		$(target).tagit({
			autocomplete: {
				source: window.location.origin + '/restaurants/' + $(target).data('restaurant').toString() + '/menu_complete.json' + '?term=' + $(target).val()
			},
			placeholderText: "#메뉴_이름_태그"
		});
	};
};

// Reset star rating and menu tags.
function resetCommentsNew() {
	starRatingForm();
	$('#new_comment .menu_comments_tag').tagit("removeAll");
};


$(document).on('ready page:load', function() {
	// Comments#index
	showStarRating();

	// Comments#new
	starRatingForm();
	commentContentsValidation('#new_comment');
	autocompleteMenus('#new_comment .menu_comments_tag');
});
