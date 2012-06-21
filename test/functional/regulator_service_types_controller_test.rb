require 'test_helper'

include Devise::TestHelpers

class RegulatorServiceTypesControllerTest < ActionController::TestCase
  setup do
    @regulator_service_type = regulator_service_types(:regulator_service_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regulator_service_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show regulator_service_type" do
    get :show, :id => @regulator_service_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @regulator_service_type.to_param
    assert_response :success
  end

  test "should destroy regulator_service_type" do
    assert_difference('RegulatorServiceType.count', -1) do
      delete :destroy, :id => @regulator_service_type.to_param
    end

    assert_redirected_to regulator_service_types_path
  end
end
