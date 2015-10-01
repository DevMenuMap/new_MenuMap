module UsersHelper
	# User who signed up with omniauth would not see email input.
	def enable_email_edit_omniauth_user(user)
		user.provider == 'facebook' && user.email.match(/^fb\_[0-9]+@menumap.co.kr$/)	? 'none' : 'initial'
	end

	# Show profile image or facebook img.
	def profile_img(user)
		if user.fb_img
			image_tag user.fb_img, alt: "#{user.username}님의 프로필 사진", class: 'profile_img'
		else
			image_tag 'users/default_profile.png', class: 'profile_img'
		end
	end

	# Check if correct user is doing the action.
	def correct_user?(user)
		current_user && user == current_user
	end

	def user_id_if_exists(user)
		user.id unless user.nil?
	end
end
