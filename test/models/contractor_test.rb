require "test_helper"

class ContractorTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should be able to create a contractor" do
    contractor = @user.added_contractors.new(name: "name", email: "test@email.com", number: "07123000123", town: "town")
    assert contractor.save!
  end

  test "should not be able to create a contractor without a name" do
    assert_not @user.added_contractors.new(email: "test@email.com", number: "07123000123", town: "town").save
  end

  test "should be able to get the trades that a contractor is associated with" do
    contractor = contractors(:c_builder)
    assert_equal 6, contractor.trades.size
  end
end
