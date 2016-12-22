require 'test_helper'

class PrivilegesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get privileges_create_url
    assert_response :success
  end

  test "should get destroy" do
    get privileges_destroy_url
    assert_response :success
  end

end
