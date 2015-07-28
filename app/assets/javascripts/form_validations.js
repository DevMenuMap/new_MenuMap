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
