function removeMymapIcon() {
	$('a.destroy_mymap').on('confirm:complete', function(e, response) {
		$('.info_window').hide();

		if ( response ) {
			var index = $(this).closest('div').data('mymap-index');
			$('.nmap_overlay_pane img:nth-of-type(' + index + ')').hide();
		};
	});
}

function updateMymapIcon(index, group) {
	var target = $('.nmap_overlay_pane img:nth-of-type(' + index + ')')
	if ( target.length != 0 ) {
		target.attr('src', groupIconPath(group));
	} else {
		$('.nmap_overlay_pane img:nth-of-type(1)').attr('src', groupIconPath(group));
	};
}
