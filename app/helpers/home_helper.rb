module HomeHelper
	def total_restaurants
		number_with_delimiter(Restaurant.count)
	end

	def total_restaurants_with_menu
		number_with_delimiter(Restaurant.where("menu_on > 0").count)
	end

	def total_menus
		number_with_delimiter(Menu.count)
	end

	def remove_the_last_parenthesis_pair(text)
		text.gsub(/\([^\(]*\)$/, '')
	end

	def time_ago_in_ko(time)
		diff = (Time.now - time).to_i
		if diff < 10
			'방금'
		elsif diff < 60
			"#{diff}초 전"
		elsif diff < 60**2
			"#{diff/60}분 전"
		elsif diff < (60**2)*12
			"#{diff/(60**2)}시간 전"
		elsif diff < (60**2)*24*365
			I18n.l time, format: '%-m월 %-d일 %p %l:%M'
		else
			I18n.l time, format: '%Y년 %-m월 %-d일 %p %l:%M'
		end
	end

	def time_in_ko(time)
		I18n.l time, format: '%Y년 %-m월 %-d일 %p %l:%M'
	end
end
