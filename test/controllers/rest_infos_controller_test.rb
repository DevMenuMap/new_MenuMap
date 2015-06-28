require 'test_helper'

class RestInfosControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@rest_info1 = rest_infos(:rest_info1)
		@rest_info2 = rest_infos(:rest_info2)

		@restaurant1 = restaurants(:restaurant1)
	end

  test "should get static pages" do
    get :new, restaurant_id: @restaurant1.id
    assert_response :success
    get :edit, id: @rest_info1.id
    assert_response :success
  end
end
