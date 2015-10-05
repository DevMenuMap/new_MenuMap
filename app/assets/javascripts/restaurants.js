function hidePaginateButton(total, current) {
	if ( total >= 6 ) {
		// First page 
		if ( current == 4 ) {
			$('a[rel="start"]').hide();
		} else {
			$('a[rel="start"]').show();
		};

		// Last page
		if ( current == total - 3 ) {
			$("a:contains('" + total + "')").hide();
		} else {
			$("a:contains('" + total + "')").show();
		};
	};
};


$(document).on('ready page:load', function() {
	$("#carousel .item:first-of-type").addClass("active");

	// Change restaurants#show tab color.
	var prev_tab = $('#rst_show_tabs a[href="#menu"]');

	$(prev_tab).css({"color": "#ea4c15", "font-weight": "bold"});

	// Change font color on show tabs.
	$('#rst_show_tabs a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		$(prev_tab).css({ "color": "black", "font-weight": "normal"});
		$(this).css({ "color": "#ea4c15", "font-weight": "bold"});
		prev_tab = this;
	});

	$('#rst_show_map').click(function() {
		$(prev_tab).css({ "color": "black", "font-weight": "normal"});
		$(this).css({ "color": "#ea4c15", "font-weight": "bold"});
		$('#tab_map').click();
		prev_tab = this;
	});
});
