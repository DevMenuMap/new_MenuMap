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

	def slang
    @result = Slang.where("? LIKE CONCAT('%', name, '%')", params[:contents] ).first
		respond_to do |format|
			format.json
		end
	end

	def info_window
		@id = params[:id]
		@name = params[:name]
		respond_to do |format|
			format.js
		end
	end
end
