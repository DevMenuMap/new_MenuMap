require 'test_helper'

class HomeControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

  test "should get brandpage" do
		get :brandpage
    assert_response :success
  end
end
