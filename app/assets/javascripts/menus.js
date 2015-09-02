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

	// toggle chevron
	$('#new_menu_section > a > div').click(function() {
		$(this).find("i").toggleClass("fa-chevron-up");
	});

	// Show or make invisible when clicking menu_titles
	$('#menu_menu_title_id').change(function(){
		if ($(this).val() == 'new') {
			$('#menu_title_form').css('display', 'block');
			$(this).closest('form').find('label[for=menu_name]').css('margin-top', '15px');
		} else {
			$('#menu_title_form').css('display', 'none');
			$(this).closest('form').find('label[for=menu_name]').css('margin-top', '0px');
		};
	});
});
