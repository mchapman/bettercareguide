require 'test_helper'

include Devise::TestHelpers

class InternalRegulatorScoresControllerTest < ActionController::TestCase
  setup do
    @internal_regulator_score = internal_regulator_scores(:internal_regulator_scores_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_regulator_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show internal_regulator_score" do
    get :show, :id => @internal_regulator_score.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @internal_regulator_score.to_param
    assert_response :success
  end

  test "should destroy internal_regulator_score" do
    assert_difference('InternalRegulatorScore.count', -1) do
      delete :destroy, :id => @internal_regulator_score.to_param
    end

    assert_redirected_to internal_regulator_scores_path
  end
end
