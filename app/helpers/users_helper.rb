module UsersHelper
	# User who signed up with omniauth would not see email input.
	def enable_email_edit_omniauth_user(user)
		user.provider == 'facebook' && user.email.match(/^fb\_[0-9]+@menumap.co.kr$/)	? 'none' : 'initial'
	end
end
