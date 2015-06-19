require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@notice1 = notices(:notice1)
		@notice2 = notices(:notice2)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notice1.id
    assert_response :success
  end
end
