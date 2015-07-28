//# Check if image file's size is over 15 megabytes
//#sizeChecker = (file_size) ->
//#	if file_size > 15
//#		alert("so big image")
//
//# Check if the file has image filetype
//#fileTypeChecker = (file_name) ->
//#	file_type = file_name.split(".").pop().toLowerCase()
//	# number '0' has special meaning
//#	if file_type && $.inArray(file_type, ["jpg", "jpeg", "png", "gif"]) == -1
//#		alert("wrong file_type")
//#		false
//
//#jQuery ->
//#	$("[data-validate='image']").change ->
//#		file_size = this.files[0].size/1024/1024
//#		file_name = this.files[0].name
//#		sizeChecker(file_size)
//#		fileTypeChecker(file_name)


//variable to check file
var valid = true;

function sizeChecker(file_size) {
	file_size = file_size / 1024 / 1024;
	if (file_size > 15) {
		alert("so big image");
		return false;
	} else { return true; }
};

function fileTypeChecker(file_name) {
	var ext = file_name.split(".").pop().toLowerCase();
	if ($.inArray( ext, ["jpg", "jpeg", "png", "gif"] ) == -1 ) {
		alert("wrong file type"); 
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
		alert("fail");
		e.preventDefault();
	}
};
