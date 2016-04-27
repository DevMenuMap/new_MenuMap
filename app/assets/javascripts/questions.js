function questionsValidation() {
	$('#new_question').validate({
		rules: {
			'question[email]' : { 
				email: true
			},
			'question[contents]' : {
				required: true,
				maxlength: 255
			},
      'consent' : { required: true }
		},
		messages: {
			'question[email]' : { 
				email: '이메일 형식이 잘못되었습니다.'
			},
			'question[contents]' : {
				required: '질문 내용을 입력해주세요.',
				maxlength: '255자 이내로 적어주세요.'
			},
      'consent' : '필수사항입니다.'
		}
	});
};
