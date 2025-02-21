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

  test "should be able to check if connected with another user" do
    user = users(:one)
    assert user.connected_with?(users(:two))
    assert_not user.connected_with?(users(:four))
  end
end
