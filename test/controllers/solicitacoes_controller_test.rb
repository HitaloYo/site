require "test_helper"

class SolicitacoesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get solicitacoes_index_url
    assert_response :success
  end
end
