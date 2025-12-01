require "test_helper"

class StaticpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get sobre" do
    get staticpages_sobre_url
    assert_response :success
  end

  test "should get contato" do
    get staticpages_contato_url
    assert_response :success
  end

  test "should get ajudalogin" do
    get staticpages_ajudalogin_url
    assert_response :success
  end
end
