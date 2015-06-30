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
    get :edit, id: @question1.id
    assert_response :success
    get :show, id: @question1.id 
    assert_response :success
  end

	test 'index has links' do
		get :index
		assert_select 'a[href=?]', edit_question_path(@question1), count: 1
		assert_select 'a[href=?]', question_path(@question2), count: 2
	end

	test 'show has links' do
		get :show, id: @question1
		assert_select 'a[href=?]', edit_question_path(@question1), count: 1
		assert_select 'a[href=?]', question_path(@question1), count: 2
	end
end
