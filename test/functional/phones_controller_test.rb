require 'test_helper'

include Devise::TestHelpers

class PhonesControllerTest < ActionController::TestCase
  setup do
    @phone = phones(:phones_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show phone" do
    get :show, :id => @phone.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @phone.to_param
    assert_response :success
  end

  test "should destroy phone" do
    assert_difference('Phone.count', -1) do
      delete :destroy, :id => @phone.to_param
    end

    assert_redirected_to phones_path
  end
end
