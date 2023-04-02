require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:danray)
  end
  
  test "should get home" do
    get root_url
    assert_response :success
  end
end
