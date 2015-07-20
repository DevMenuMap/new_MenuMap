class AddrConversionsController < ApplicationController
	before_action :admin?
	
  def index
		@addr_conversions = AddrConversion.all.order(:address_id)
  end

  def new
		@address = Address.find(params[:address_id])
		@addr_conversion = AddrConversion.new
  end

	def create
		@address = Address.find(params[:address_id])
		@addr_conversion = @address.addr_conversions.new(addr_conversion_params)
		@addr_conversion.convert_to = @address.name
		
		if @addr_conversion.save
			flash[:alert] = "succeed in addr_conversions#create"
			redirect_to addr_conversions_url
		else
			flash[:alert] = "fail in addr_conversions#create"
			redirect_to new_address_addr_conversion_path(@address)
		end
	end

  def edit
		@addr_conversion = AddrConversion.find(params[:id])
  end

	def update
		@addr_conversion = AddrConversion.find(params[:id])
		if @addr_conversion.update(addr_conversion_params)
			flash[:alert] = "succeed in addr_conversions#update"
			redirect_to addr_conversions_url
		else
			flash[:alert] = "fail in addr_conversions#update"
			redirect_to edit_addr_conversion_url(@addr_conversion)
		end
	end

	def destroy
		AddrConversion.find(params[:id]).update(active: false)
		flash[:alert] = "done addr_conversions#destroy"
		redirect_to :back
	end

	private
		def addr_conversion_params
			params.require(:addr_conversion).permit(:convert_from)
		end
end
