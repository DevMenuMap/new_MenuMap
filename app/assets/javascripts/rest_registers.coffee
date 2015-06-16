jQuery ->
	$("#new_rest_register :submit").click ->
		mustFill = [] 
		mustFill.push("name") if !$("#rest_register_name").val()
		# User should select subcategory(not "전체")
		mustFill.push("category")	if $("#subcategory_select").val() == "1"
		mustFill.push("addr") if !$("#rest_register_addr").val()
		if mustFill.length != 0
			mustFill = mustFill.join(", ").concat(" should be submitted")
			alert(mustFill)
			false
