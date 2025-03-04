require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be able to create a user" do
    user = User.new(email: "test@example.com", first_name: "name", last_name: "surname", password: "password", confirmed_at: Time.now)
    assert user.save!
  end

  test "should not be able to create a user without an email" do
    assert_not User.new(first_name: "name", last_name: "surname", password: "password", confirmed_at: Time.now).save
  end

  test "should not be able to create a user without a firstname and lastname" do
    assert_not User.new(email: "test@example.com", password: "password", confirmed_at: Time.now).save
    assert_not User.new(email: "test@example.com", first_name: "name", password: "password", confirmed_at: Time.now).save
    assert_not User.new(email: "test@example.com", last_name: "surname", password: "password", confirmed_at: Time.now).save
  end

  test "should not be able to create a user without a password" do
    assert_not User.new(email: "test@example.com", first_name: "name", last_name: "surname", confirmed_at: Time.now).save
  end

  test "should not be able to create a user with a duplicate email" do
    User.create!(email: "test@example.com", first_name: "name", last_name: "surname", password: "password", confirmed_at: Time.now)
    assert_not User.new(email: "test@example.com", first_name: "name", last_name: "surname", password: "password", confirmed_at: Time.now).save
  end

  test "should not be able to create a user with an invalid email" do
    assert_not User.new(email: "testexample.com", first_name: "name", last_name: "surname", password: "password", confirmed_at: Time.now).save
  end

  test "should not be able to create a user with a password that is too short" do
    assert_not User.new(email: "test@example.com", first_name: "name", last_name: "surname", password: "pass", confirmed_at: Time.now).save
  end

  test "should be able to get connected users" do
    user = users(:one)
    assert_equal 2, user.connections.size
    assert_equal 2, user.connected_users.size
  end

  test "should be able to get an array of connected user IDs and self" do
    user = users(:one)
    assert_equal [ users(:two).id, users(:three).id, user.id ].sort, user.connected_user_ids_and_self.sort
  end

  test "should be able to check if connected with another user" do
    user = users(:one)
    user2 = users(:two)
    assert user.connected_with?(user2)
    assert user2.connected_with?(user)
    assert_not user.connected_with?(users(:four))
  end

  test "should be able to get the full name of a user" do
    user = users(:one)
    assert_equal "one test_user", user.full_name
  end

  test "should be able to connect with a user with the create_connection_with method" do
    user = users(:one)
    user.create_connection_with(users(:five))
    assert user.connected_with?(users(:five))
  end

  test "should be able to get the connection link for a user" do
    user = users(:one)
    assert_equal "http://www.example.com/connections/new?user_a_id=#{user.id}", user.connection_link("www.example.com")
  end

  test "should be able to get the contractors added by a user" do
    user = users(:one)
    assert_equal 3, user.added_contractors.size
  end

  test "should be able to get the jobs for a user" do
    user = users(:one)
    assert_equal 5, user.jobs.size
  end

  test "should be able to get the ratings for a user" do
    user = users(:one)
    assert_equal 2, user.ratings.size
  end

  test "should be able to get the contractors rated by user" do
    user = users(:one)
    assert_equal 2, user.rated_contractors.size
  end

  test "should be able to get the contractors rated by connections" do
    user = users(:two)
    assert user.connected_with?(users(:one))
    rated_by_connection_count = users(:one).rated_contractors.size + users(:three).rated_contractors.size
    assert_equal rated_by_connection_count, user.contractors_rated_by_connections.size
  end

  test "should be able to see contractors that user has added or have been rated by connections" do
    user = users(:one)
    rated_by_connections = users(:two).rated_contractors + users(:three).rated_contractors
    added = user.added_contractors
    used = user.used_contractors
    rated  = user.rated_contractors
    expected_viewable_count = (rated_by_connections + added + used + rated).uniq.size
    assert_equal expected_viewable_count, user.viewable_contractors.size

    user = users(:two)
    rated_by_connections = users(:one).rated_contractors + users(:three).rated_contractors
    added = user.added_contractors
    used = user.used_contractors
    rated  = user.rated_contractors
    expected_viewable_count = (rated_by_connections + added + used + rated).uniq.size
    assert_equal expected_viewable_count, user.viewable_contractors.size
  end
end
