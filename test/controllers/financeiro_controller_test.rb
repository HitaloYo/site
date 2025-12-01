require "test_helper"

class FinanceiroControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get financeiro_index_url
    assert_response :success
  end
end
