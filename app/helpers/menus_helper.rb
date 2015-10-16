module MenusHelper
	def show_menu_comments_link(menu)
		if menu.menu_comments.exists?
			content_tag :div, class: 'menu_comments_link' do
				menu.menu_comments.count.to_s + '개 댓글 보기'
			end
		end
	end

	def menu_price_div(menu)
		content_tag :div, class: "price" do
			# when menu's price is unidentified
			if menu.unidentified
				menu_unidentified_div(menu)
			# when menu is not sitga
			elsif !menu.sitga
				menu_won_div(menu)
			# when menus is sitga without price
			elsif menu.price == 0 || !menu.price
				menu_sitga_div_without_price(menu)
			# when price exists and sitga
			else
				concat menu_won_div(menu)
				concat menu_sitga_div_with_price(menu)
			end
		end
	end

	def menu_unidentified_div(menu)
		content_tag :div, "가격 미확인", class: 'price', style: 'color: #5890ff;'
	end

	def menu_won_div(menu)
		content_tag :div, class: "won" do
			menu.unidentified ? "가격 미확인" : menu.price_in_won
		end
	end
	
	def menu_sitga_div_with_price(menu)
		content_tag :div, "(시가)", class: "sitga", style: 'color: #5890ff; font-size: 80%;'
	end

	# when menu has only sitga true, div's class would be 'price'.
	def menu_sitga_div_without_price(menu)
		content_tag :div, "시가", class: "price"
	end

	def menu_title_link_with_name(menu_title)
		link_to menu_title.title_name, edit_menu_title_path(menu_title)
	end

	def brief_menu_price_info(menu)
		info = [] 
		info << menu.price_in_won 	if menu.price
		info << '싯가'							if menu.sitga
		info << '미확인'						if menu.unidentified
		info.join(', ')
	end
end
