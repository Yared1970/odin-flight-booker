require "test_helper"

class PassengersControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get passengers_name_url
    assert_response :success
  end

  test "should get email" do
    get passengers_email_url
    assert_response :success
  end
end
