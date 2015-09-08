function imageUploadValidate() {
	$("input.uploadImage").MultiFile({
		accept: 'gif|jpg|jpeg|png',
		maxfile: 15 * 1024,
		STRING: {
			remove: "취소",
			duplicate: "$file 은 이미 선택된 파일입니다.",
			denied: "$ext 는 업로드 할 수 없는 확장자입니다.",
			toobig: "$file 은 용량이 너무 큽니다. (최대: 15 Mb)"
			//selected:
		}
	});
};

function onePictureValidation() {
	if ( $('#picture_img_list').children().length == 0 ) {
		alert("사진을 먼저 '+' 추가해주세요.");
		return false;
	} else {
		return true;
	};
};

$(document).on('ready page:load', function() {
	$('#new_picture').on('submit', function() {
		if ( !onePictureValidation() ) {
			return false;
		};
	});
});
