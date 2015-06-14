jQuery ->
	# click or change
	$("#category_select").click ->
		$.ajax 
			url: "home/update_sub_categories"
			datatype: "script"
			data:
				category: $("#category_select").val()

	# Autocomplete address name on search page
	$("#addrcomplete")
		.autocomplete 
			# autoFocus: false
			source: "/home/addrcomplete"
			minLength: 0
			focus:  (event, ui) ->
								$("#addrcomplete").val(ui.item.name)
								false
			select: (event, ui) ->
								$("#addrcomplete").val(ui.item.name)
								false
		.data("uiAutocomplete")._renderItem = (ul, item) ->
								$("<li></li>").data("item.autocomplete", item)
									.append("<a>" + item.name + "</a>")
									.appendTo(ul)
