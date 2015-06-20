require 'test_helper'

class MenuTitlesControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@title1 = menu_titles(:title1)
		@hidden_title = menu_titles(:hidden_title)
	end

  test "should get static pages" do
    get :index
    assert_response :success
    get :edit, id: @title1.id
    assert_response :success
  end
	
	test 'index has links' do
		get :index
		# edit link
		assert_select 'a[href=?]', edit_menu_title_path(@title1), count: 1
		# destroy link
		assert_select 'a[href=?]', menu_title_path(@title1), count: 1
	end
end
