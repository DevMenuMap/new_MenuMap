$(document).ready( function() {
	$('#new_menu').validate({
		rules: {
			'menu[name]': { required: true }
		}
	});
});
