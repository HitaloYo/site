require "test_helper"

class EnviarSolicitacaoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enviar_solicitacao_index_url
    assert_response :success
  end
end
