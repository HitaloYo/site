require "test_helper"

class AjudaLoginControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ajuda_login_index_url
    assert_response :success
  end
end
