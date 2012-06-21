require 'test_helper'

include Devise::TestHelpers

class AddressTypesControllerTest < ActionController::TestCase
  setup do
    @address_type = address_types(:address_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:address_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show address_type" do
    get :show, :id => @address_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @address_type.to_param
    assert_response :success
  end

  test "should destroy address_type" do
    assert_difference('AddressType.count', -1) do
      delete :destroy, :id => @address_type.to_param
    end

    assert_redirected_to address_types_path
  end
end
