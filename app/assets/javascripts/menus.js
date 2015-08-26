$(document).on('ready page:load', function() {
	$('#new_menu').validate({
		rules: {
			'menu[name]': { required: true }
		}
	});
});
