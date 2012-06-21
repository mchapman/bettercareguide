require 'test_helper'

include Devise::TestHelpers

class PhoneTypesControllerTest < ActionController::TestCase
  setup do
    @phone_type = phone_types(:phone_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show phone_type" do
    get :show, :id => @phone_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @phone_type.to_param
    assert_response :success
  end

  test "should destroy phone_type" do
    assert_difference('PhoneType.count', -1) do
      delete :destroy, :id => @phone_type.to_param
    end

    assert_redirected_to phone_types_path
  end
end
