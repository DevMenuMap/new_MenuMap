require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
	# For authentication on header file
	include Devise::TestHelpers

	def setup
		@question1 = questions(:question1)
		@question2 = questions(:question2)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question1.id
    assert_response :success
  end

  test "should get show" do
    get :show, id: @question1.id 
    assert_response :success
  end
end
