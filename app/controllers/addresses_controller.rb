class AddressesController < ApplicationController
	before_action :admin?
	
  def index
		@seoul = Address.find(11 * 1000000000)
		@addr_tag_categories = Address.addr_tag_category
  end

	def show
		@address = Address.find(params[:id])

		# Change this to normal data passing codes to js
		@coord_array = []
		@address.coordinates.each do |c|
			@coord_array << c.lat.to_f << c.lng.to_f
		end

		# Find Center point
		y = []
		x = []
		area = 0
		@center_x = 0
		@center_y = 0
		l = @coord_array.length / 2
		for i in 0..(l-1)
			y << @coord_array[2*i]
			x << @coord_array[2*i+1]
		end
		x << x[0]
		y << y[0]
		for i in 0..(l-1)
			area += (x[i].to_f * y[i+1].to_f - x[i+1].to_f * y[i].to_f ) / 2
		end
		for i in 0..(l-1)
			@center_x += ( (x[i].to_f + x[i+1].to_f) *
			(x[i].to_f * y[i+1].to_f - x[i+1].to_f * y[i].to_f) ) / (6 * area)
			@center_y += ( (y[i].to_f + y[i+1].to_f) *
			(x[i].to_f * y[i+1].to_f - x[i+1].to_f * y[i].to_f) ) / (6 * area)
		end
		@center_x = @center_x.abs
		@center_y = @center_y.abs
	end

	def new
	end

	def create
	end

	def edit
		@address = Address.find(params[:id])
		@address.coordinates.build
		@address.addr_bounds.build
	end

	def update
		@address = Address.find(params[:id])
		latlng = params[:address][:coordinates_attributes]["0"]
		0.upto(latlng[:lat].length - 1) do |n|
			@address.coordinates.create(lat: latlng[:lat][n].to_f, lng: latlng[:lng][n].to_f)
		end
		
		# Check if new addr_bounds are different from what address had before.
		addr_codes = addr_bound_params
		if addr_codes != @address.addr_bound_array
			# Destroy all addr_bounds, addr_tags and 
			# create new addr_bounds with params
			@address.addr_bounds.destroy_all
			@address.addr_tags.destroy_all
			create_new_addr_bounds(addr_codes)
		end
		
		# Need nested attribute creation failure check
		flash[:alert] = "addresses#update"
		redirect_to address_url(@address)
	end

	# It destroys assciated "coordinates", not "address"
	def destroy
		@address = Address.find(params[:id])
		@address.coordinates.each do |c|
			c.destroy
		end
		redirect_to address_url(@address)
	end

	private
		def address_params
			# permission check for :coordinates
			params.require(:address).permit(:coordinates)
		end

		# Return an array of addr_bound number codes.
		def addr_bound_params
		byebug
			params[:address][:addr_bounds_attributes]["0"][:addr_code].reject!{ |a| a.empty? }.sort
		end

		# Create new addr_bounds with parameter array only with addr_codes.
		def create_new_addr_bounds(addr_codes)
			addr_codes.each do |ac|
				@address.addr_bounds.create(addr_code: ac)
			end
		end
end
