require 'test_helper'

class MenuTitlesControllerTest < ActionController::TestCase
	include Devise::TestHelpers

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: 1
    assert_response :success
  end
end
