require 'test_helper'

include Devise::TestHelpers

class CountriesControllerTest < ActionController::TestCase
  setup do
    @country = countries(:countries_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show country" do
    get :show, :id => @country.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @country.to_param
    assert_response :success
  end


  test "should destroy country" do
    assert_difference('Country.count', -1) do
      delete :destroy, :id => @country.to_param
    end

    assert_redirected_to countries_path
  end
end
