require "test_helper"

class Public::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get btn" do
    get public_favorites_btn_url
    assert_response :success
  end
end
