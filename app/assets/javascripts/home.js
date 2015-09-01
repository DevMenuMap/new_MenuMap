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

	var prev_tab = $('#rst_show_tabs a[href="#menu"]');

	$(prev_tab).css({"color": "#dd4814", "font-weight": "bold"});

	// Change font color on show tabs.
	$('#rst_show_tabs a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		$(prev_tab).css({ "color": "black", "font-weight": "normal"});
		$(this).css({ "color": "#dd4814", "font-weight": "bold"});
		prev_tab = this;
	});

	$('#rst_show_map').click(function() {
		$(prev_tab).css({ "color": "black", "font-weight": "normal"});
		$(this).css({ "color": "#dd4814", "font-weight": "bold"});
		$('#tab_map').click();
		prev_tab = this;
	});

	$('#menu_section a[aria-expanded="true"] span').css('border-left-color', 'green');

	$('#menu_section li').on('show.bs.collapse', function(){
		$(this).find('span').css('border-left-color', 'green');
	});

	$('#menu_section li').on('hide.bs.collapse', function(){
		$(this).find('span').css('border-left-color', '#dd4814');
	});
});
