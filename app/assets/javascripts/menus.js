// Show or make invisible when clicking menu_titles
function expandTitleForm(selectedTitle) {
	if (selectedTitle.val() == 'new') {
		$('#menu_title_form').css('display', 'block');
		selectedTitle.closest('form').find('label[for=menu_name]').css('margin-top', '15px');
	} else {
		if (selectedTitle.val() == 'none') {
			alert('메뉴목록을 선택해주세요.');
		};
		$('#menu_title_form').css('display', 'none');
		selectedTitle.closest('form').find('label[for=menu_name]').css('margin-top', '0px');
	};
};

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

	// Change chevron on cascading dropdown.
	$('#new_menu_section > a > div').click(function() {
		$(this).find("i").toggleClass("fa-chevron-up");
	});

	// Change menu list left border on click.
	var firstTitle = $('#menu_section a[aria-expanded="true"]')
	var green = '#23b300'

	// When the page is loaded for the first time.
	firstTitle.data('border-color', green);
	firstTitle.find('span').css('border-color', green);

	// After the first change.
	$('a[data-border-color]').on('click', function() {
		if ( $(this).data('border-color') == green ) {
			$(this).data('border-color', 'orange');
			$(this).find('span').css('border-color', 'orange');
		} else {
			$(this).data('border-color', green);
			$(this).find('span').css('border-color', green);
		}
	});
});
