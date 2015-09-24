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

// Prevent Slangs.
function slangCheck(formRoute, textRoute) {
	$( formRoute ).on('submit', function(event) {
		var url = window.location.origin + '/home/slang';
		$.ajax({
			url: url,
			data: { contents: $( textRoute ).val() },
			success: function( data ) {
				if (data.status) {
					alert("'" + josaChecker(data.slang, '은') + " 금지된 단어입니다.");
				};
			}
		});
	});
};


$(document).on('ready page:load', function() {
	// Comments#index
	showStarRating();

	// Comments#new
	starRatingForm();
	disableCommentPaste('#comment_contents');
	commentContentsValidation('#new_comment');
	autocompleteMenus('#new_comment .menu_comments_tag');
	slangCheck("#new_comment", "#comment_contents")
});
