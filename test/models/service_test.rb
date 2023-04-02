require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  def setup
    user = users(:danray)
    @service = user.services.build(name: "Supremo", price: "100", available_date_time: DateTime.new(2023, 4, 2, 12, 0, 0))
  end

  test "should be valid" do 
    assert @service.valid?
  end
end
