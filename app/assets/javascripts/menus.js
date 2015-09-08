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

// Toggle left_border_label's color on click.
function toggleLabelColor(title) {
	var green = '#23b300';

	if ( title.data('border-color') == green ) {
		title.data('border-color', 'orange');
		title.find('span').css('border-color', 'orange');
	} else {
		title.data('border-color', green);
		title.find('span').css('border-color', green);
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

	// When the page is loaded for the first time.
	$('#menu_section a[aria-expanded="true"] span').css('border-color', '#23b300');
});
