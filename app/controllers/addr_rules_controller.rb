class AddrRulesController < ApplicationController
	before_action :admin?, :except => [:show, :new, :create]
	
  def index
		# 10 items per page
		@addr_rules = AddrRule.paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
			format.html
			format.json { render json: @addr_rules}
			format.js
		end
  end

  def show
		@addr_rule = AddrRule.find(params[:id])

		# Change this to normal data passing codes to js
		@coord_array = []
		@addr_rule.coordinates.each do |c|
			@coord_array << c.lat.to_f << c.lng.to_f
		end
		
		# Find Center point
		x = []
		y = []
		@center_x = 0
		@center_y = 0
		
		if( @coord_array != [] )
			l = @coord_array.length / 2
			for i in 0..(l-1)
				x << @coord_array[2*i]
				y << @coord_array[2*i+1]
			end

			@center_x = (x.inject{|sum, n| sum + n}) / x.length
			@center_y = (y.inject{|sum, n| sum + n}) / y.length
		end
  end

  def new
		@addr_rule = AddrRule.new
		@addr_rule.coordinates.build
  end

	def create
		@addr_rule = AddrRule.new(addr_rule_params)	
		@addr_rule.user_id = current_user.id if current_user

		latlng = params[:addr_rule][:coordinates_attributes]["0"]

		if @addr_rule.save
			0.upto(latlng[:lat].length - 1) do |n|
				@addr_rule.coordinates.create(lat: latlng[:lat][n].to_f, lng: latlng[:lng][n].to_f)
			end

			flash[:alert] = "succeed in addr_rules#create"
			redirect_to addr_rule_url(@addr_rule)
		else
			flash[:alert] = "fail in addr_rules#create"
			redirect_to :back
		end
	end

	def destroy
		AddrRule.find(params[:id]).update(active: false)
		flash[:alert] = "succeed in addr_rules#pseudo-destroy"
		redirect_to addr_rules_url
	end

	private
		def addr_rule_params
			params.require(:addr_rule).permit(:name, :coordinates_attributes)
		end
end
