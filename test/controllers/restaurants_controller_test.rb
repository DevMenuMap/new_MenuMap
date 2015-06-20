require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@restaurant1 = restaurants(:restaurant1)
		@hidden_restaurant = restaurants(:restaurant2)
		@menu_title = menu_titles(:title1)
		@hidden_title = menu_titles(:hidden_title)
	end

  test "should get static pages" do
    get :index
    assert_response :success
    get :show, id: @restaurant1.id
    assert_response :success
    get :new
    assert_response :success
    get :edit, id: @restaurant1.id
    assert_response :success
  end

	test "index has links" do
		get :index
		assert_select 'a[href=?]', new_restaurant_path, count: 1
		# show, destroy would be counted as the same link
		assert_select 'a[href=?]', restaurant_path(@restaurant1), count: 2
		# inactivated restaurant should not appear
		assert_select 'a[href=?]', restaurant_path(@hidden_restaurant), count: 0
	end

	test 'show has links' do
		get :show, id: @restaurant1.id
		# Restaurant
		assert_select 'a[href=?]', edit_restaurant_path, count: 1
		assert_select 'a[href=?]', restaurants_path, count: 1
		# RestInfo
		assert_select 'a[href=?]', edit_rest_info_path(@restaurant1.rest_info), count: 1
		assert_select 'a[href=?]', rest_info_path(@restaurant1.rest_info), count: 1
		# MenuTitle	
		assert_select 'a[href=?]', edit_menu_title_path(@menu_title), count: 1
		assert_select 'a[href=?]', edit_menu_title_path(@hidden_title), count: 0
	end

	test 'edit has original form value' do 
		get :edit, id: @restaurant1.id
		assert_select '#restaurant_name[value=?]', @restaurant1.name
	end

	# test menu_titles listed if active
	#	assert_select '.menu_title', count: @restaurant1.menu_titles.count 
end
