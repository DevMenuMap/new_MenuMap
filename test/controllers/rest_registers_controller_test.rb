require 'test_helper'

class RestRegistersControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@register1 = rest_registers(:register1)
		@register2 = rest_registers(:register2)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @register1.id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
