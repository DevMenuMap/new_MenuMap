module SharesHelper
	# Facebook
	def fb_share_url(user)
		"http://www.facebook.com/sharer/sharer.php?u=#{ENV['CURRENT_IP']}/users/#{user.username}/MyMap"
	end
end
