require 'test_helper'

class StockControllerTest < ActionController::TestCase
  test "should get index,show" do
    get :index,show
    assert_response :success
  end

end
