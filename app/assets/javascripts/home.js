$(document).ready( function() {
	$("#category_select").change( function() {
		$.ajax({
			url: window.location.origin + '/home/update_subcategories',
			dataType: "script",
			data: {
				category: $("#category_select").val()
			}
		});
	});
	
	// variable for autocompleting address name on search page
	var addrComplete = $("#addrcomplete").autocomplete( {
		// autoFocus: false
		source: window.location.origin + '/home/addrcomplete',
		minLength: 0,
		focus: function(event, ui) {
			$("#addrcomplete").val(ui.item.name);
			return false;
		},
		select:	function(event, ui) {
			$("#addrcomplete").val(ui.item.name);
			return false;
		}
	}).data('uiAutocomplete');

	// Only when there is #addrcomplete(search page), this code works
	if (addrComplete) {
		addrComplete._renderItem = function(ul,item) {
			return $("<li></li>").data("item.autocomplete", item)
											.append("<a>" + item.name + "</a>")
											.appendTo(ul);
		};
	};

	// Change angle on cascading dropdown.
	$('.dropdown_angle').on('click', function() {
		$(this).find('i').toggleClass('fa-angle-down');
	});
});

