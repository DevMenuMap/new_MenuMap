class HomeController < ApplicationController
	
	def brandpage
	end

	def about
	end

	def manual
	end

	def qna
	end

	def search
		@categories = Category.all
		@subcategories = Subcategory.all
	end

	def update_sub_categories
		@subcategories = Category.find_by(name: params[:category])
														 .subcategories
		respond_to do |format|
			format.js
		end
	end
end
