require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@picture1 = pictures(:picture1)
		@picture2 = pictures(:picture2)
	end

  test "should get static pages" do
    get :index
    assert_response :success
    get :new
    assert_response :success
    get :edit, id: @picture2.id
    assert_response :success
  end
end
