jQuery ->
	$("#new_question :submit").click ->
		if !$("#new_question #question_contents").val()
			alert("경고: contents should not be blank!")
			false
