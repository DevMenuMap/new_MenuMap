module CommentsHelper
	# When there is no comments, don't show.(show if second param is false)
	def display_none_if_comment_exists(comments, none = true)
		comments.blank? == none ? 'block' : 'none'
	end

	# Check if a comment has a star rating.
	def star_rating_exists?(comment)
		!(comment.rating.blank? || comment.rating == 0)
	end

	# Concatenate menu_comments.
	def blue_menu_comment_tags(comment)
		text = ''
		comment.menu_comments.each do |mc|
			text += '#' + mc.menu.name + ' '
		end
		text.gsub(/\s$/, '')
	end
end
