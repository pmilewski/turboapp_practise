require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  test "should get landing_page" do
    get static_pages_landing_page_url
    assert_response :success
  end

  test "should redirect dashboard to login when not signed in" do
    get static_pages_dashboard_url
    assert_redirected_to new_user_session_url
  end

  test "should get dashboard when signed in" do
    user = users(:one)
    sign_in user
    get static_pages_dashboard_url
    assert_response :success
  end
end
