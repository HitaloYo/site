require "test_helper"

class AlunoOnlineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get aluno_online_index_url
    assert_response :success
  end
end
