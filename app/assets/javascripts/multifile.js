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

function textByteCheck(str) {
	var m = encodeURIComponent(str).match(/%[89ABab]/g);
	return str.length + (m ? m.length : 0);
};