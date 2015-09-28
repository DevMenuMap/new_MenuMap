// Show comments for clicked menu.
function showCommentsModal() {
	$("li.menu").on('click', function(){
		if ( $(this).data('menu-comments') == true ) {
			$.ajax({
				url: '/menus/' + $(this).data('menu') + '/menu_comments',
			});
		};
	});
};


$(document).on('ready page:load', function() {
	showCommentsModal();
});
