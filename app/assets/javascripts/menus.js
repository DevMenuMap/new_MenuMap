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

// Show or make invisible when clicking menu_titles
function expandTitleForm(selectedTitle) {
	if (selectedTitle.val() == 'new') {
		$('#menu_title_form').css('display', 'block');
		selectedTitle.closest('form').find('label[for=menu_name]').css('margin-top', '15px');
	} else {
		if (selectedTitle.val() == 'none') {
			alert('메뉴목록을 선택해주세요.');
			redOutline(selectedTitle);
		};
		$('#menu_title_form').css('display', 'none');
		selectedTitle.closest('form').find('label[for=menu_name]').css('margin-top', '0px');
	};
};

// Menu form validations
// For menu_titles
function menuTitleValidation() {
	var title = $('#menu_menu_title_id');
	var titleName = $('#menu_title_title_name');

	if ( title.val() == 'none' ) {
		alert('메뉴 목록을 선택해주세요.');
		redOutline(title);
	} else if ( title.val() == 'new' && titleName.val().length == 0 ) {
		alert('메뉴 목록을 입력해주세요. 예) 주요메뉴, 음료 및 주류 등');
		redOutline(titleName);
	} else {
		return true;
	};
};

// For menus
function menuValidation() {
	var name = $('#menu_name');
	var price = $('#menu_price');
	var sitga = $('#menu_sitga');
	var unidentified = $('#menu_unidentified');

	if ( name.val().length == 0 ) {
		alert('메뉴 이름을 적어주세요.');
		redOutline(name);

	// When unidentified and sitga are all false.
	} else if ( !unidentified.is(':checked') && !sitga.is(':checked') ) {
		if ( price.val().length == 0 ) {	
			alert("가격을 적어주세요.\n가격을 모르실 경우 '미확인'을 체크해주세요.");
			redOutline(price);
		} else if ( price.val() % 10 != 0 ) {
			alert("가격은 숫자만 적어주세요.\n가격을 모르실 경우 '미확인'을 체크해주세요.");
			redOutline(price);
		} else {
			return true;
		};

	// When both unidentified and sitga are true.
	} else if ( unidentified.is(':checked') && sitga.is(':checked') ) {
		alert("메뉴 가격이 시가인 경우 '미확인' 체크를 해제해주세요");
	} else {
		return true;
	}
}

// When unidentified is checked, disable price input.
function disablePrice() {
	if ( $('#menu_unidentified').is(':checked') ) {
		$('#menu_price').prop('disabled', true);
	} else {
		$('#menu_price').prop('disabled', false);
	};
};


$(document).on('ready page:load', function() {

	// Change chevron on cascading dropdown.
	$('#new_menu_section > a > div, #new_comment_section > a > div').on('click', function() {
		$(this).find('i').toggleClass('fa-chevron-up');
		$(this).find('i').toggleClass('fa-chevron-down');
	});

	// Prepare for toggleLabelColor().
	$('#menu_section ul li a').data('border-color', '#e5e5e5')
	// When the page is loaded for the first time.
	$('#menu_section ul li:first-child a > div').click();

	// Validation when menu form is submitted.
	$('#menu_form').on('submit', function() {
		if ( !(menuTitleValidation() && menuValidation()) ) {
			return false;
		};
	});
});
