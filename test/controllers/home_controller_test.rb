require 'test_helper'

class HomeControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

  test "should get brandpage" do
		get :brandpage
    assert_response :success
  end

  test "should have links" do
		get :brandpage
		assert_select "a[href=?]", root_path, count: 1 
		assert_select "a[href=?]", about_path, count: 1 
		assert_select "a[href=?]", manual_path, count: 1 
		assert_select "a[href=?]", qna_path, count: 1 
		assert_select "a[href=?]", search_path, count: 1 
		assert_select "a[href=?]", new_rest_register_path, count: 1 
		assert_select "a[href=?]", restaurants_path, count: 1 
		assert_select "a[href=?]", rest_errs_path, count: 1 
		assert_select "a[href=?]", menu_titles_path, count: 1 
		assert_select "a[href=?]", pictures_path, count: 1 
		assert_select "a[href=?]", new_user_registration_path, count: 1 
		assert_select "a[href=?]", new_user_session_path, count: 1 
		assert_select "a", count: 12
		get :search
		assert_select "input[type=submit]", count: 1
  end
end
