require "test_helper"

class BaixarDocumentoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get baixar_documento_index_url
    assert_response :success
  end
end
