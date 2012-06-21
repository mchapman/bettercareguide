require 'test_helper'

include Devise::TestHelpers

class RegulatorSectorTypesControllerTest < ActionController::TestCase
  setup do
    @regulator_sector_type = regulator_sector_types(:regulator_sector_types_001)
    @admin_user = users(:admin)
    sign_in @admin_user
    @mass_assignable =  {:regulator_description => "Voluntary", :regulator_id => 1, :internal_sector_type_id => 6}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regulator_sector_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regulator_sector_type" do
    assert_difference('RegulatorSectorType.count') do
      post :create, :regulator_sector_type => @mass_assignable
    end

    assert_redirected_to regulator_sector_type_path(assigns(:regulator_sector_type))
  end

  test "should show regulator_sector_type" do
    get :show, :id => @regulator_sector_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @regulator_sector_type.to_param
    assert_response :success
  end

  test "should update regulator_sector_type" do
    put :update, :id => @regulator_sector_type.to_param, :regulator_sector_type => @mass_assignable
    assert_redirected_to regulator_sector_type_path(assigns(:regulator_sector_type))
  end

  test "should destroy regulator_sector_type" do
    assert_difference('RegulatorSectorType.count', -1) do
      delete :destroy, :id => @regulator_sector_type.to_param
    end

    assert_redirected_to regulator_sector_types_path
  end
end
