require 'test_helper'

class RestInfosControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@rest_info1 = rest_infos(:rest_info1)
		@rest_info2 = rest_infos(:rest_info2)
		@restaurant1 = restaurants(:restaurant1)
	end

  test "should get new" do
    get :new, restaurant_id: @restaurant1.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rest_info1.id
    assert_response :success
  end
end
