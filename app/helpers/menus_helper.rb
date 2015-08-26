module MenusHelper
	def won_div(menu)
		content_tag :div, class: "won" do
			menu.unidentified ? "미확인" : menu.price_in_won
		end
	end
	
	def sitga_div(menu)
		content_tag :div, "(싯가)", class: "sitga" if menu.sitga
	end
end
