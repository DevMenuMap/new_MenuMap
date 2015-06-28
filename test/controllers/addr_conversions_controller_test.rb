require 'test_helper'

class AddrConversionsControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@addr_conversion1 = addr_conversions(:addr_conversion1)
		@addr_conversion2 = addr_conversions(:addr_conversion2)

		@address1 = addresses(:address1)
	end

  test "should get static pages" do
    get :new, address_id: @address1.id
    assert_response :success
    get :edit, id: @addr_conversion1.id
    assert_response :success
  end
end
