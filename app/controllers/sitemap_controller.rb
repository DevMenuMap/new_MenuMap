class SitemapController < ApplicationController
	# Sitemap.xml doesn't need layouts.
	layout nil

  def index
		@static = "http://menumap.co.kr/"
		# Additional restaurants for picture uploaded restaurants.
		@restaurants = Restaurant.where("menu_on > 0 OR delivery is true OR updated_at > ?", Time.now - 7.day)

		respond_to do |format|
			format.xml 
		end
  end

  def naver_seo
  	@restaurant = Restaurant.find(1000000 + Time.now.min)

  	respond_to do |format|
  		format.atom
  	end
  end
end
