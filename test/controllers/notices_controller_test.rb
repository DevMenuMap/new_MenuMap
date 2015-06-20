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
    get :new
    assert_response :success
    get :edit, id: @notice1.id
    assert_response :success
  end

	test "index has links" do
		get :index
		assert_select 'a[href=?]', new_notice_path, count: 1
		assert_select 'a[href=?]', edit_notice_path(@notice1), count: 1
		assert_select 'a[href=?]', notice_path(@notice1), count: 1
	end
end
