require 'test_helper'

include Devise::TestHelpers

class PagesControllerTest < ActionController::TestCase

  setup do
    @punter = users(:punter)
    sign_in @punter
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

end
