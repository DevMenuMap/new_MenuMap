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
		content_tag :div, "미확인", class: 'price', style: 'color: #5890ff;'
	end

	def menu_won_div(menu)
		content_tag :div, class: "won" do
			menu.unidentified ? "미확인" : menu.price_in_won
		end
	end
	
	def menu_sitga_div_with_price(menu)
		content_tag :div, "(시가)", class: "sitga", style: 'color: #5890ff; font-size: 80%;'
	end

	# when menu has only sitga true, div's class would be 'price'.
	def menu_sitga_div_without_price(menu)
		content_tag :div, "시가", class: "price"
	end
end
