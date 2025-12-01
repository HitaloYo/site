require "test_helper"

class OnWorkControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get on_work_index_url
    assert_response :success
  end
end
