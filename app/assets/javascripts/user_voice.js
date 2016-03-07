function userVoiceValidation() {
  $('#new_user_voice').validate({
    rules: {
      'user_voice[email]' : { 
        email: true
      },
      'user_voice[description]' : {
        required: true,
        maxlength: 2000
      }
    },
    messages: {
      'user_voice[email]' : { 
        email: '이메일 형식이 잘못되었습니다.'
      },
      'user_voice[description]' : {
        required: '건의 하실 내용을 입력해주세요.',
        maxlength: '1000자 이내로 적어주세요.'
      }
    }
  });
};
