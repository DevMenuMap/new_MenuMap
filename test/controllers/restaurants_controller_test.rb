require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@restaurant1 = restaurants(:restaurant1)
		@restaurant2 = restaurants(:restaurant2)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @restaurant1.id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @restaurant2.id
    assert_response :success
  end
end
