require 'test_helper'

class MenuTitlesControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@title1 = menu_titles(:title1)
		@title2 = menu_titles(:title2)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @title1.id
    assert_response :success
  end
end
