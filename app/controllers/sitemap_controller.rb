class SitemapController < ApplicationController
	layout nil

  def index
		@static = "http://menumap.co.kr/"
		@restaurants = Restaurant.where("menu_on > 0 OR created_at > ?", Time.now - 7.days).order(created_at: :desc)

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
