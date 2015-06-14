class HomeController < ApplicationController
	# Autocomplete address name in search page
	# full option makes any substirngs(not only starting strings) captured
	# autocomplete :addrcomplete, :name, full: true
	
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

	def addrcomplete
		@addrcomplete = Addrcomplete.where("name like ?", "%#{params[:term]}%")
																.limit(10)

		respond_to do |format|
			format.json { render :json => @addrcomplete.to_json }
		end
	end
end
