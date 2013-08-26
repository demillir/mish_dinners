require 'test_helper'

class CalendarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_redirected_to '/lo/lo'
  end

  test "should show calendar" do
    get :show, :division_id => 'lo', :unit_id => 'lo'
    assert_response :success
  end
end
