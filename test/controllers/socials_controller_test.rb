require 'test_helper'

class SocialsControllerTest < ActionController::TestCase
  test "should get share_rest" do
    get :share_rest
    assert_response :success
  end

end
