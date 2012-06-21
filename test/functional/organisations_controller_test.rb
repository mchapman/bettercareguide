require 'test_helper'

include Devise::TestHelpers

class OrganisationsControllerTest < ActionController::TestCase
  setup do
    @organisation = organisations(:organisations_001)
    @organisation.addresses << addresses(:addresses_001)
    @organisation.phones << phones(:phones_001)
    @admin_user = users(:admin)
    sign_in @admin_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organisations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

#  test "should create organisation" do
#    assert_difference('Organisation.count') do
#      post :create, :organisation => @organisation.attributes
#    end
#
#    assert_redirected_to organisation_path(assigns(:organisation))
#  end

  test "should show organisation" do
    get :show, :id => @organisation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @organisation.to_param
    assert_response :success
  end

  test "should destroy organisation" do
    assert_difference('Organisation.count', -1) do
      delete :destroy, :id => @organisation.to_param
    end

    assert_redirected_to organisations_path
  end
end
