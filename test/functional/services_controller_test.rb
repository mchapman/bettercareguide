require 'test_helper'

include Devise::TestHelpers

class ServicesControllerTest < ActionController::TestCase
  setup do
    @service = services(:one)
    @service.organisation = organisations(:organisations_001)
    @service.organisation.addresses << addresses(:addresses_001)
    @service.organisation.phones << phones(:phones_001)
    @admin_user = users(:admin)
    sign_in @admin_user
    @mass_assignable = {:date_started_trading=>'Thu, 09 Sep 2010', :date_started_trading_implied=>false, :capacity=>1, :description=>"MyText", :elevator_pitch=>"We are brill", :organisation_id=>1}

  end

  test "should create service" do
    assert_difference('Service.count') do
      post :create, :service => @mass_assignable
    end

    assert_redirected_to service_path(assigns(:service))
  end

  test "should update service" do
    put :update, :id => @service.to_param, :service => @mass_assignable
    assert_redirected_to service_path(assigns(:service))
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete :destroy, :id => @service.to_param
    end
    assert_redirected_to services_path
  end

end
