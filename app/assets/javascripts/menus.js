$(document).on('ready page:load', function() {
	$('#new_menu').validate({
		rules: {
			'menu[name]': { required: true }
		}
	});

	$(".menu").click(function(){
		$.ajax({
			url: '/comments/show',
			data: {
				menu_id: $(this).data('menu-comments')
			}
		});
	});

	$("#menu_section ul li:first-child a > div").click();
});
