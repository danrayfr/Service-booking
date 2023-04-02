require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  def setup
    user = users(:danray)
    @service = user.services.build(name: "Supremo", price: "100")
  end

  test "should be valid" do 
    assert_not @service.valid?
  end
end
