require "test_helper"

class ContractorTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @contractor = contractors(:c_builder)
  end

  test "should be able to create a contractor" do
    contractor = @user.added_contractors.new(name: "name", email: "test@email.com", number: "07123000123", town: "town")
    assert contractor.save!
  end

  test "should not be able to create a contractor without a name" do
    assert_not @user.added_contractors.new(email: "test@email.com", number: "07123000123", town: "town").save
  end

  test "should be able to get the trades that a contractor is associated with" do
    assert_equal 6, @contractor.trades.size
  end

  test "should be able to get the customers that a contractor has worked for" do
    assert_equal 1, @contractor.customers.size
  end

  test "should be able to get the ratings that a contractor has received" do
    assert_equal 1, @contractor.ratings.size
  end

  test "should be able to get a contractors viewable jobs given a user" do
    assert_equal 4, @contractor.viewable_jobs(@user).size
    assert_equal 0, @contractor.viewable_jobs(users(:four)).size
  end

  test "should be able to get a contractors viewable customers given a user" do
    assert_equal 1, @contractor.viewable_customers(users(:two)).size
    assert_equal 0, @contractor.viewable_customers(users(:four)).size
  end

  test "should be able to get a contractors viewable ratings given a user" do
    assert_equal 1, @contractor.viewable_ratings(users(:two)).size
    assert_equal 0, @contractor.viewable_ratings(users(:four)).size
  end

  test "should be able to get a contractors average rating given a user" do
    assert_equal 9.0, @contractor.average_rating(users(:two))
    assert_nil @contractor.average_rating(users(:four))
  end
end
