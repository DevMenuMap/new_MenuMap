jQuery ->
	$("#category_select").change ->
		$.ajax 
			url: "home/update_sub_categories"
			datatype: "script"
			data:
				category: $("#category_select").val()

	# variable for autocompleting address name on search page
	addrComplete = $("#addrcomplete").autocomplete
			# autoFocus: false
			source: "/home/addrcomplete"
			minLength: 0
			focus: 	(event, ui) ->
								$("#addrcomplete").val(ui.item.name)
								false
			select: (event, ui) ->
								$("#addrcomplete").val(ui.item.name)
								false
	.data("uiAutocomplete")

	# Only when there is #addrcomplete(search page), this code works
	if addrComplete
		addrComplete._renderItem = (ul, item) ->
				$("<li></li>").data("item.autocomplete", item)
											.append("<a>" + item.name + "</a>")
											.appendTo(ul)
