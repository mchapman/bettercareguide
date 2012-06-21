require 'test_helper'

include Devise::TestHelpers

class OwnershipTypesControllerTest < ActionController::TestCase
  setup do
    @ownership_type = ownership_types(:ownership_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ownership_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show ownership_type" do
    get :show, :id => @ownership_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ownership_type.to_param
    assert_response :success
  end

  test "should destroy ownership_type" do
    assert_difference('OwnershipType.count', -1) do
      delete :destroy, :id => @ownership_type.to_param
    end

    assert_redirected_to ownership_types_path
  end
end
