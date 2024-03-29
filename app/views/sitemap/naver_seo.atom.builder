naver_atom_feed({xmlns: "http://webmastertool.naver.com", id: 'http://menumap.co.kr'}) do |feed|
	feed.title("MenuMap")
	feed.author do |a|
		a.name("MenuMap")
	end
	feed.updated(@restaurants[0].created_at) if @restaurants.length > 0
	feed.link(rel: 'site', href: (request.protocol + request.host_with_port),
						title: 'MenuMap')

	@restaurants.each do |restaurant|
		feed.naver_entry(restaurant, {id: restaurant_url(restaurant)}) do |entry|
			entry.title(restaurant_meta_title(restaurant))
			entry.author do |a|
				a.name("MenuMap")
			end
			entry.updated(restaurant.last_updated_at.xmlschema)
			entry.published(restaurant.created_at.xmlschema)
			entry.link(rel: 'via', href: (request.protocol + request.host_with_port))
			entry.content(restaurant_meta_description(restaurant), type: 'html')
		end
	end
end
