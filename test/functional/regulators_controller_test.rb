require 'test_helper'

include Devise::TestHelpers

class RegulatorsControllerTest < ActionController::TestCase
  setup do
    @regulator = regulators(:regulators_001)
    @admin_user = users(:admin)
    sign_in @admin_user
    @mass_assignable = {:domain => "England", :web_page_format=>"http://www.cqc.org.uk/registeredservicesdirectory/RSSearchDetail.asp?ID=%010d", :organisation_id=>1, :description=>"care Quality", :short_name=>"CQC"}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regulators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regulator" do
    assert_difference('Regulator.count') do
      post :create, :regulator => @mass_assignable
    end

    assert_redirected_to regulator_path(assigns(:regulator))
  end

  test "should show regulator" do
    get :show, :id => @regulator.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @regulator.to_param
    assert_response :success
  end

  test "should update regulator" do
    put :update, :id => @regulator.to_param, :regulator => @mass_assignable
    assert_redirected_to regulator_path(assigns(:regulator))
  end

  test "should destroy regulator" do
    assert_difference('Regulator.count', -1) do
      delete :destroy, :id => @regulator.to_param
    end

    assert_redirected_to regulators_path
  end
end
