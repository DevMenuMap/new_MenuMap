class AddressesController < ApplicationController
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
	end

	def new
	end

	def create
	end

	def edit
		@address = Address.find(params[:id])
		@address.coordinates.build
	end

	def update
		@address = Address.find(params[:id])
		latlng = params[:address][:coordinates_attributes]["0"]
		0.upto(latlng[:lat].length - 1) do |n|
			@address.coordinates.create(lat: latlng[:lat][n].to_f, lng: latlng[:lng][n].to_f)
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
end
