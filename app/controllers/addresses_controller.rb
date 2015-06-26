class AddressesController < ApplicationController
  def index
		@seoul = Address.find(11 * 1000000000)
		@addr_tag_categories = Address.addr_tag_category
  end
end
