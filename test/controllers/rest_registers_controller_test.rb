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
    get :show, id: @register1.id
    assert_response :success
    get :new
    assert_response :success
  end

	test 'index has links' do
		get :index
		assert_select 'a[href=?]', rest_register_path(@register1), count: 2
	end
end
