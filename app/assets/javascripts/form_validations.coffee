# Check if image file's size is over 15 megabytes
sizeChecker = (file_size) ->
	if file_size > 0.2
		alert("so big image")

# Check if the file has image filetype
fileTypeChecker = (file_name) ->
	file_type = file_name.split(".").pop().toLowerCase()
	# number '0' has special meaning
	if file_type && $.inArray(file_type, ["jpg", "jpeg", "png", "gif"]) == -1
		alert("wrong file_type")
		false

jQuery ->
	$("[data-validate='image']").change ->
		file_size = this.files[0].size/1024/1024
		file_name = this.files[0].name
		sizeChecker(file_size)
		fileTypeChecker(file_name)

	# Check if some input is blank
	$("[data-validate='fill']").blur ->
		if !$(this).val()
			alert("it's necessary")
