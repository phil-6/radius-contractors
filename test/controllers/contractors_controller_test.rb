require "test_helper"

class ContractorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contractor = contractors(:one)
    sign_in users(:one)
  end

  # test "should get index" do
  #   get contractors_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_contractor_url
  #   assert_response :success
  # end
  #
  # test "should create contractor" do
  #   assert_difference("Contractor.count") do
  #     post contractors_url, params: { contractor: { added_by_id: @contractor.added_by_id, email: "test@email.com", name: @contractor.name, number: "07123000123", town: @contractor.town } }
  #   end
  #
  #   assert_redirected_to contractor_url(Contractor.last)
  # end
  #
  # test "should show contractor" do
  #   get contractor_url(@contractor)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_contractor_url(@contractor)
  #   assert_response :success
  # end
  #
  # test "should update contractor" do
  #   patch contractor_url(@contractor), params: { contractor: { added_by_id: @contractor.added_by_id, email: @contractor.email, name: @contractor.name, number: @contractor.number, town: @contractor.town } }
  #   assert_redirected_to contractor_url(@contractor)
  # end
end
