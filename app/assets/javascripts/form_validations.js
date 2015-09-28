//variable to check file
var valid = true;

function sizeChecker(file_size) {
	file_size = file_size / 1024 / 1024;
	if (file_size > 15) {
		return false;
	} else { return true; }
};

function fileTypeChecker(file_name) {
	var ext = file_name.split(".").pop().toLowerCase();
	if ($.inArray( ext, ["jpg", "jpeg", "png", "gif"] ) == -1 ) {
		return false;
	} else { return true; }
};

function formValidation() {
	if ( fileTypeChecker( this.files[0].name ) && sizeChecker( this.files[0].size ) ) { 
		valid = true;
	} else {
		valid = false;
	}
};

function checkValidation(e) {
	if (valid) {
	} else {
		alert("error occured in formValidation()");
		e.preventDefault();
	}
};

// Korean orthography
function josaChecker(txt, josa) {
	var code = txt.charCodeAt(txt.length-1) - 44032;
	var cho = 19, jung = 21, jong=28;
	var i1, i2, code1, code2;

	// No text
	if (txt.length == 0) return '';

	// No Korean
	if (code < 0 || code > 11171) return txt;

	if (code % 28 == 0) return txt + josaChecker.get(josa, false);
	else return txt + josaChecker.get(josa, true);
}

josaChecker.get = function (josa, jong) {
	// jong = true 받침있음, jong = false 받침없음

	if (josa == '을' || josa == '를') return (jong?'을':'를');
	if (josa == '이' || josa == '가') return (jong?'이':'가');
	if (josa == '은' || josa == '는') return (jong?"'은":"'는");
	if (josa == '와' || josa == '과') return (jong?'와':'과');

	// Unidentified josa
	return 'wrong josa';
}

// Validation for input that should have at leash one character.
function mustFillInput(targetForm) {
	var validate = true;
	targetForm.find('[data-must-fill]').each( function(i) {
		if ( $(this).val().length == 0 ) {
			alert( josaChecker($(this).data('must-fill'), '을') + ' 입력해주세요.' );
			redOutline($(this));
			validate = false;
			return false;
		}
	});
	return validate;
};

$(document).on('ready page:load', function() {
	$('form').on('submit', function() {
		if ( !mustFillInput($(this))	) { return false };
	});
});
