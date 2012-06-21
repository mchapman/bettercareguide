require 'test_helper'

include Devise::TestHelpers

class InternalServiceTypesControllerTest < ActionController::TestCase
  setup do
    @internal_service_type = internal_service_types(:internal_service_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_service_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show internal_service_type" do
    get :show, :id => @internal_service_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @internal_service_type.to_param
    assert_response :success
  end

  test "should destroy internal_service_type" do
    assert_difference('InternalServiceType.count', -1) do
      delete :destroy, :id => @internal_service_type.to_param
    end

    assert_redirected_to internal_service_types_path
  end
end
