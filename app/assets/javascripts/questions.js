function formValidation(e, id) {
	var allInputs = $(id).children("input:text, textarea");
	var i;
	var l = allInputs.length;

	for(i = 0; i < l; i++) {
		if ($.trim( allInputs.eq(i).val() ) == "" ) {
			alert("경고: " + allInputs.eq(i).attr("data-validate") + " should not be blank!");
			e.preventDefault();
			break;
		}
	}
};
