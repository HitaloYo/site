require "test_helper"

class SolicitarBoletoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get solicitar_boleto_index_url
    assert_response :success
  end
end
