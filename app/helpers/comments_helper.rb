module CommentsHelper
	# When there is no comments, don't show.(show if second param is false)
	def display_none_when_comment_exists(comments, none = true)
		comments.blank? == none ? 'block' : 'none'
	end
end
