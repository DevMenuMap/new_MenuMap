// Validation for username's length.
function usernameLength() {
	var text = $('#user_username').val();
	if ((textByteCheck(text) > 0) && (textByteCheck(text) < 6)) {
		alert('유저명은 한글 2글자, 영어 6글자 이상이어야 합니다.');
		redOutline($('#user_username'));
		return false;
	} else {
		return true;
	};
};

$(document).on('ready page:load', function() {
	$('#new_user').on('submit', function() {
		if ( !usernameLength() ) return false;
	});

	$('#new_user').validate({
		rules: {
			'user[email]' : { email: true },
			'user[password]': { minlength: 8 },
			'user[password_confirmation]': { equalTo: '#user_password' }
		},
		messages: {
			'user[email]' : '이메일 형식이 잘못되었습니다.',
			'user[password]': '비밀번호는 8자 이상이어야 합니다.',
			'user[password_confirmation]': { 
				equalTo: '비밀번호가 일치하지 않습니다.' }
		}
	});
});
