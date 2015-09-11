module SocialsHelper
	def kakaotalk_link_label(restaurant)
		txt = '[' + restaurant.name + ']\n'
		txt += '전화번호: ' + restaurant.phnum + '\n' if !restaurant.phnum.blank?
		restaurant.menus.blank? ? txt += '음식분류: ' : txt += '주요메뉴: '
		txt += menus_or_category(restaurant).gsub(/\<\/?span\>/, '') + '\n'
		txt += '주소: ' + restaurant.addr
	end
end
