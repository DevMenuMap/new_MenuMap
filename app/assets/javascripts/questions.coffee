jQuery ->
	$("#new_question").bind "submit", (event) ->
		if !$("#new_question #question_contents").val()
			alert("경고: contents should not be blank!")
			false
