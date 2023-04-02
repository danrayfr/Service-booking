require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "DanRay Rollan", mobile: "09560635541", email: "danray@admin.com", password: "password", password_confirmation: "password")
  end

  test "name should be present" do 
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "mobile should not be longer than 11 digits" do
    @user.mobile = "123456789"
    assert_not @user.valid?

    @user.mobile = "123456789012"
    assert_not @user.valid?

    @user.mobile = ""
    assert_not @user.valid?

    @user.mobile = nil
    assert_not @user.valid?
  end

  test "mobile number only contains positive numbers without spaces" do
    @user.mobile = "123 456 7890"
    assert_not @user.valid?

    @user.mobile = "-1234567890"
    assert_not @user.valid?

    @user.mobile = "abc"
    assert_not @user.valid?
  end

  test "new user should be a user by default" do
    assert_not @user.admin?
  end
end
