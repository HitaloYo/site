require "test_helper"

class AmbienteVirtualControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ambiente_virtual_index_url
    assert_response :success
  end
end
