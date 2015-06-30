require 'test_helper'

class RestErrsControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@rest_err1 = rest_errs(:rest_err1)
		@rest_err2 = rest_errs(:rest_err2)
	end

  test "should get static pages" do
    get :index
    assert_response :success
    get :show, id: @rest_err1.id
    assert_response :success
    get :edit, id: @rest_err2.id
    assert_response :success
  end

  test "index has links" do
		# show and destroy links have the same format
		get :index
		assert_select 'a[href=?]', rest_err_path(@rest_err1), count: 2 
  end

	test 'show has links' do 
		get :show, id: @rest_err1.id
		assert_select 'a[href=?]', edit_rest_err_path(@rest_err1), count: 1
	end
end
