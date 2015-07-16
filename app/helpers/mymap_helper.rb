module MymapHelper
	# Show MyMap information more with Ajax call to modal.
	def show_mymap_info_button(mymap)
		link_to "show_mymap_info", mymap_path(mymap.id), id: "show_mymap_#{mymap.id}", remote: true
	end
end
