$(document).on('ready page:load', function() {
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
	$('.dropdown_angle').click(function() {
		$(this).find('i').toggleClass('fa-angle-down');
	});

	// Click original file add button with customized button.
	$(".file_select").click( function() {
		$(this).closest("form").children("div").children("input").last().click();
	});

	// Change font color on show tabs.
	$('#rst_show_tabs a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		$(this).css({ "color": "#dd4814", "font-weight": "bold"});
	});
});
