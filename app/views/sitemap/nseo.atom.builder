naver_atom_feed({xmlns: "http://webmastertool.naver.com", id: 'http://52.69.51.63:3000'}) do |feed|
	feed.title("Menumap")
	feed.author do |a|
		a.name("Menumap")
	end
	feed.updated(@restaurants[0].created_at) if @restaurants.length > 0
	feed.link(:rel => 'site', :href => (request.protocol + request.host_with_port),
						:title => 'Menumap')

	@restaurants.each do |restaurant|
		feed.naver_entry(restaurant, {id: restaurant_url(restaurant)}) do |entry|
			entry.title(restaurant.name)
			entry.author do |a|
				a.name("Menumap")
			end
			entry.updated(restaurant.updated_at.xmlschema)
			entry.published(restaurant.created_at.xmlschema)
			entry.link(:rel => 'via', :href => (request.protocol + request.host_with_port))
			entry.content(restaurant.addr, :type => 'html')
		end
	end
end