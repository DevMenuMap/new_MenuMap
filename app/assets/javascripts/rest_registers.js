// rest_registers validation
$(document).on('ready page:load', function() {
	$('#new_rest_register').on('submit', function() {
		if ($('#rest_register_name').val().length == 0) {
			alert('음식점 이름을 적어주세요.');
			redOutline($('#rest_register_name'));
			return false;
		} else if ($('#category_select').val() == '1000000') {
			alert('음식점 분류를 선택해주세요.');
			redOutline($('#category_select'));
			return false;
		} else if ($('#subcategory_select').val() % 10000 == 0) {
			alert('음식점 분류를 선택해주세요.');
			redOutline($('#subcategory_select'));
			return false;
		} else if ($('#rest_register_addr').val().length == 0) {
			alert('음식점의 주소를 적어주세요.');
			redOutline($('#rest_register_addr'));
			return false;
		};
	});
});
