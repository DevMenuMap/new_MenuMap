require 'test_helper'

class RestErrsControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@rest_err1 = rest_errs(:rest_err1)
		@rest_err2 = rest_errs(:rest_err2)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @rest_err1.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rest_err2.id
    assert_response :success
  end
end
