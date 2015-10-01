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
	$('.nmap_overlay_pane img:nth-of-type(' + index + ')').attr('src', groupIconPath(group));
}
