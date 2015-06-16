jQuery ->
	$("#new_rest_register").bind "submit", (event) ->
		mustFill = [] 
		mustFill.push("name") if !$("#rest_register_name").val()
		# User should select subcategory(not "전체")
		mustFill.push("category")	if $("#subcategory_select").val() == "1"
		mustFill.push("addr") if !$("#rest_register_addr").val()
		if mustFill.length != 0
			mustFill = mustFill.join(", ").concat(" should be submitted")
			alert(mustFill)
			false
	
	# Check submitted filetype
	$("#new_rest_register").bind "submit", (event) ->
		fileType = $("#rest_register_img").val().split(".").pop().toLowerCase()
		# number '0' has special meaning
		if fileType && $.inArray(fileType, ["jpg", "jpeg", "png", "gif"]) == -1
			alert("wrong filetype")
			false
