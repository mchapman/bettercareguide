require 'test_helper'

include Devise::TestHelpers

class AddressesControllerTest < ActionController::TestCase
  setup do
    @address = addresses(:addresses_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show address" do
    get :show, :id => @address.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @address.to_param
    assert_response :success
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, :id => @address.to_param
    end

    assert_redirected_to addresses_path
  end
end
