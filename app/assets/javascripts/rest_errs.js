// Check rest_err validation.
function restErrValidation() {
	if ( !$('#rest_err_presence_err').is(':checked') && !$('#rest_err_menu_err').is(':checked') && !$('#rest_err_phnum_err').is(':checked') && !$('#rest_err_category_err').is(':checked') && $('#rest_err_etc').val().length == 0 ) {
		alert('오류 사항을 체크하거나 적어주세요.');
		return false;
	} else {
		return true;
	};
}
