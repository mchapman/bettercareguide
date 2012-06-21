require 'test_helper'

include Devise::TestHelpers

class OwnershipsControllerTest < ActionController::TestCase
  setup do
    @ownership = ownerships(:one)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ownerships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show ownership" do
    get :show, :id => @ownership.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ownership.to_param
    assert_response :success
  end

  test "should destroy ownership" do
    assert_difference('Ownership.count', -1) do
      delete :destroy, :id => @ownership.to_param
    end

    assert_redirected_to ownerships_path
  end
end
