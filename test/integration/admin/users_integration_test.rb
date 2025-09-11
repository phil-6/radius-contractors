require "test_helper"

class Admin::UsersIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:one)
    sign_in @admin
  end

  test "should get index" do
    get admin_users_url
    assert_response :success
  end

  test "should show user" do
    get admin_user_url(@user)
    assert_response :success
    assert_select "h2", @user.full_name
  end

  test "should send reset password instructions" do
    post reset_password_admin_user_url(@user)
    assert_redirected_to admin_user_url(@user)
    follow_redirect!
    assert_select "div.flash", "Password reset email sent."
  end

  test "non-admin should be redirected from index" do
    sign_out @admin
    sign_in @user
    get admin_users_url
    assert_redirected_to root_path
  end
end
