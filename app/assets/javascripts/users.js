// Only logged in users can do.
function needLogin() {
	$('#new_comment_section').on('click', function(e) {
		if ( !($(this).find('#new_comment').data('user') > 0) ) {
			if ( confirm('로그인을 해주세요.') ) {
				window.location.href = 'http://menumap.co.kr/users/sign_in';
			} else {
				return false;
			};
		};
	});
};

// Alert when user didn't chnage his/her username 
// when signed in via facebook.
function changeUsernameAlert(e, isChanged, username) {
	if (!isChanged) {
		var text = "현재 유저명이 " + username + "입니다.\n";
		text +=	"유저명을 바꿔주세요.";
		if ( confirm(text) ) {
			window.location.href = 'http://menumap.co.kr/users/edit';
		};
	};
};


$(document).on('ready page:load', function() {
	needLogin();

	// Username starts only with Korean or English.
	$.validator.addMethod('usernameStart', function(value, element) {
		return value.match(/^[a-zA-Z가-힣]/)
	}, 'start with Korean or English');

	// Validation for username's length.
	$.validator.addMethod("usernameMinLength", function(value, element) {
		return textByteCheck(value) >= 6
	}, 'too short username');

	$.validator.addMethod("usernameMaxLength", function(value, element) {
		return value.length < 21 
	}, 'too long username');

	// Username format validation
	$.validator.addMethod('usernameFormat', function(value, element) {
		return value.match(/^[a-zA-Z0-9_\-가-힣]+$/)
	}, 'invalid username format');

	$('#new_user, .edit_user').validate({
		rules: {
			'user[email]' : { 
				required: true,
				email: true 
			},
			'user[username]' : { 
				required: true, 
				usernameStart: true,
				usernameMinLength: true,
				usernameMaxLength: true,
				usernameFormat: true
			},
			'user[current_password]': { required: true },
			'user[password]': { minlength: 8 },
			'user[password_confirmation]': { equalTo: '#user_password' }
		},
		messages: {
			'user[email]' : {
				required: '이메일을 입력해주세요.',
				email: '이메일 형식이 잘못되었습니다.'
			},
			'user[username]' : {
				required: '유저명을 적어주세요.',
				usernameStart: '유저명은 한글 혹은 영어로 시작해야합니다.',
				usernameMinLength: '유저명은 한글일 경우 2글자, 영어 혹은 숫자일 경우 6글자 이상입니다.',
				usernameMaxLength: '유저명은 20자를 넘을 수 없습니다.',
				usernameFormat: '유저명은 한글, 영어, 숫자, - _ 으로만 가능합니다.'
			},
			'user[current_password]': '변경사항을 저장하기 위해 현재 비밀번호를 적어주세요.',
			'user[password]': '비밀번호는 8자 이상이어야 합니다.',
			'user[password_confirmation]': '비밀번호가 일치하지 않습니다.'
		}
	});
});
