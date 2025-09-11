require "test_helper"

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @connection = connections(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get connections_url
    assert_response :success
  end

  test "should get new" do
    get new_connection_url(user_a_id: users(:four).id)
    assert_response :success
  end

  test "should create connection" do
    assert_difference("Connection.count") do
      post connections_url, params: { user_a_id: users(:four).id }
    end

    assert_redirected_to connections_url
  end

  test "should destroy connection" do
    assert_difference("Connection.count", -1) do
      delete connection_url(@connection)
    end

    assert_redirected_to connections_url
  end
end
