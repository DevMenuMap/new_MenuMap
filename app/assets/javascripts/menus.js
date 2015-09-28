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

// Menu's overall validation.
function menuPriceValidation() {
	// MenuTitle should be selected.
	$.validator.addMethod('selectMenuTitle', function(value, element) {
		return value != 'none'
	});

	// MenuTitle's title_name is required.
	$.validator.addMethod('requireTitleName', function(value, element) {
		if ( $('#menu_menu_title_id').val() == 'new' ) {
			return value.length > 0
		} else {
			return true
		};
	});
	
	// Price should be divided by 10.
	$.validator.addMethod('priceDivBy10', function(value, element) {
		if ( value.length > 0 && !$('#menu_unidentified').is(':checked') ) {
			return value % 10 == 0
		} else {
			return true
		};
	});

	// Price should have numbers only.
	$.validator.addMethod('priceNumFormat', function(value, element) {
		if ( value.length > 0 && !$('#menu_unidentified').is(':checked') ) {
			return value >= 0 
		} else {
			return true
		};
	});

	// Price should have at least one input true.
	$.validator.addMethod('priceBlank', function(value, element) {
		return value.length > 0 || $('#menu_unidentified').is(':checked') || $('#menu_sitga').is(':checked')
	});
}

// Menu Validations
function menuValidation() {
	menuPriceValidation();
	$('#new_menu').validate({
		rules: {
			'menu[menu_title_id]' : {
				selectMenuTitle: true
			},
			'menu_title[title_name]' : {
				requireTitleName: true
			},
			'menu[name]' : {
				required: true
			},
			'menu[price]' : {
				priceNumFormat: true,
				priceDivBy10: true,
				priceBlank: true
			}
		},
		messages: {
			'menu[menu_title_id]' : {
				selectMenuTitle: '메뉴 목록을 선택해주세요.'
			},
			'menu_title[title_name]' : {
				requireTitleName: '메뉴 목록을 입력해주세요. 예) 메인메뉴, 음료 및 주류 등'
			},
			'menu[name]' : {
				required: '메뉴 이름을 적어주세요.'
			},
			'menu[price]' : {
				priceNumFormat: '가격은 숫자만 적어주세요.',
				priceDivBy10: '가격은 10원 단위로 적어주세요.',
				priceBlank: '가격을 적어주세요.'
			}
		}
	});
}

// Sitga and unidentified cannot be checked simultaneously.
function priceSitgaAndUniden() {
	$('#new_menu').on('submit', function() {
		if ( $('#menu_unidentified').is(':checked') && $('#menu_sitga').is(':checked') ) {
			alert("메뉴 가격이 시가인 경우 '가격 미확인' 부분을 해제해주세요.")
			return false;
		};
	});
};

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

	// Validation for menus.
	menuValidation();
	priceSitgaAndUniden();
});
