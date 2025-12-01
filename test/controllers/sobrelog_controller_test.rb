require "test_helper"

class SobrelogControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sobrelog_index_url
    assert_response :success
  end
end
