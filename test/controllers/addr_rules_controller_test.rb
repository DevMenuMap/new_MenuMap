require 'test_helper'

class AddrRulesControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@addr_rule1 = addr_rules(:addr_rule1)
		@addr_rule2 = addr_rules(:addr_rule2)
	end

  test "should get index" do
    get :index
    assert_response :success
    get :show, id: @addr_rule1.id
    assert_response :success
    get :new
    assert_response :success
  end
end
