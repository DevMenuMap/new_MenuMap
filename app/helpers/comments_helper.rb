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

	# Show edit and delete link modal.
	def link_to_edit_delete_comment_modal(comment)
		if correct_user?(comment.user)
			link_to modal_comment_path(comment), data: { remote: true, toggle: 'modal', target: '#myModal' } do
				content_tag :i, '', class: 'fa fa-angle-down'
			end
		end
	end

	def has_menu_comments?(comment)
		comment.menu_comments.exists? ? 'tag 있음' : nil
	end
end
