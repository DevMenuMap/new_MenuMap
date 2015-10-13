class HomeController < ApplicationController
	def brandpage
		@categories = Category.all
		@subcategories = Subcategory.all
	end

	def about
	end

	def manual
	end

	def search
		@categories = Category.all
		@subcategories = Subcategory.all
	end

	def update_subcategories
		# Check if parameter value is numeric or string(only at home#search)
		if params[:category].to_i == 0 
			@subcategories = Category.find_by(name: params[:category])
															 .subcategories
		else
			@subcategories = Category.find(params[:category]).subcategories
		end

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

	def validate_slangs
		target = params[:comment] || params[:mymap]
    @result = Slang.where("? LIKE CONCAT('%', name, '%')", target[:contents].gsub(/\s/, '')).first
		respond_to do |format|
			format.json { render json: !@result.present? }
		end
	end

	def info_window
		@restaurant = Restaurant.find(params[:id])
		@mymap = Mymap.find(params[:mymap_id])
		respond_to do |format|
			format.js
		end
	end
end
