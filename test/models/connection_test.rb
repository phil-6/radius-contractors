require "test_helper"

class ConnectionTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    assert users(:one).connected_with?(users(:two))
    assert users(:two).connected_with?(users(:one))
    assert users(:one).connected_with?(users(:three))
    assert users(:three).connected_with?(users(:one))
    assert users(:two).connected_with?(users(:three))
    assert users(:three).connected_with?(users(:two))
    assert_not users(:one).connected_with?(users(:four))
  end

  test "should not save connection without user" do
    connection = Connection.new
    assert_not connection.save, "Saved the connection without a user"
  end

  test "should not save connection with same user" do
    user = users(:one)
    connection = Connection.new(user_a: user, user_b: user)
    assert_not connection.save, "Saved the connection with the same user"
  end

  test "should save connection with different users" do
    user_a = users(:two)
    user_b = users(:four)
    connection = Connection.new(user_a: user_a, user_b: user_b)
    assert connection.save, "Did not save the connection with different users"
  end

  test "should not save connection if it already exists" do
    user_a = users(:two)
    user_b = users(:four)
    connection = Connection.new(user_a: user_a, user_b: user_b)
    connection.save
    connection = Connection.new(user_a: user_a, user_b: user_b)
    assert_not connection.save, "Saved the connection when it already exists"
  end

  test "should not save connection if it already exists with the users in a different order" do
    user_a = users(:two)
    user_b = users(:four)
    connection = Connection.new(user_a: user_a, user_b: user_b)
    connection.save
    connection = Connection.new(user_a: user_b, user_b: user_a)
    assert_not connection.save, "Saved the connection when it already exists with the users in a different order"
  end
end
