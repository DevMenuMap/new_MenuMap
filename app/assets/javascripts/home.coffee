jQuery ->
	# click or change
	$("#category_select").click ->
		$.ajax 
			url: "home/update_sub_categories"
			datatype: "script"
			data:
				category: $("#category_select").val()
