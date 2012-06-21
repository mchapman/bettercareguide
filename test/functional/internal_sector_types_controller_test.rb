require 'test_helper'

include Devise::TestHelpers

class InternalSectorTypesControllerTest < ActionController::TestCase
  setup do
    @internal_sector_type = internal_sector_types(:internal_sector_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_sector_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show internal_sector_type" do
    get :show, :id => @internal_sector_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @internal_sector_type.to_param
    assert_response :success
  end

  test "should destroy internal_sector_type" do
    assert_difference('InternalSectorType.count', -1) do
      delete :destroy, :id => @internal_sector_type.to_param
    end

    assert_redirected_to internal_sector_types_path
  end
end
