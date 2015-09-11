class BlogsController < ApplicationController
	def blog_ajax
		@restaurant = Restaurant.find(params[:id])
		@naver_blogs = @restaurant.naver_blog_search
		@daum_blogs = @restaurant.daum_blog_search
		
		respond_to do |format|
			format.js
		end
	end
end
