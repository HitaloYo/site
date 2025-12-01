require "test_helper"

class DisciplinasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get disciplinas_index_url
    assert_response :success
  end
end
