require 'test_helper'

class CalendarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_redirected_to '/lo/lo'
  end
end
