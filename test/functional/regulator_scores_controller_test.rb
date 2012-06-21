require 'test_helper'

include Devise::TestHelpers

class RegulatorScoresControllerTest < ActionController::TestCase
  setup do
    @regulator_score = regulator_scores(:regulator_scores_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regulator_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show regulator_score" do
    get :show, :id => @regulator_score.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @regulator_score.to_param
    assert_response :success
  end

  test "should destroy regulator_score" do
    assert_difference('RegulatorScore.count', -1) do
      delete :destroy, :id => @regulator_score.to_param
    end

    assert_redirected_to regulator_scores_path
  end
end
