class SitemapController < ApplicationController
	layout nil

  def index
		@static = "http://menumap.co.kr/"
		@restaurants = Restaurant.google_sitemap_restaurants

		respond_to do |format|
			format.xml 
		end
  end

  def naver_seo
  	@restaurants = Restaurant.limit(100).offset(params[:offset].to_i)

  	respond_to do |format|
  		format.atom
  	end
  end
end
