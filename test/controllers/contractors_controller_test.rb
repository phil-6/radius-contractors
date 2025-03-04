require "test_helper"

class ContractorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contractor = contractors(:c_builder)
    sign_in users(:one)
  end

  test "should get index" do
    get contractors_url
    assert_response :success
    assert_equal 6, (assigns(:contractors).size)
  end

  test "should be able to filter contractors" do
    get contractors_url, params: { trade_id: trades(:builder).id }
    assert_response :success
    assert_equal 5, (assigns(:contractors).size)

    get contractors_url, params: { trade_id: trades(:electrician).id }
    assert_response :success
    assert_equal 1, (assigns(:contractors).size)
  end

  test "should get new" do
    get new_contractor_url
    assert_response :success
  end

  test "should create contractor" do
    assert_difference("Contractor.count") do
      post contractors_url, params: { contractor: {
        email: "test@email.com", name: @contractor.name,
        company_name: @contractor.company_name,
        number: "07123000123", town: @contractor.town } }
    end

    assert_redirected_to contractor_url(Contractor.last)
  end

  test "should be able to create contractor with trades" do
    assert_difference("Contractor.count") do
      post contractors_url, params: { contractor: {
        email: "test@email.com", name: @contractor.name,
        company_name: @contractor.company_name,
        number: "07123000123", town: @contractor.town,
        trade_ids: [ trades(:building).id, trades(:plumbing).id, trades(:electrical).id ] } }
    end
  end

  test "should redirect to existing contractor if number is the same" do
    number = "07111000111"
    assert Contractor.exists?(number: number)
    assert_no_difference("Contractor.count") do
      post contractors_url, params: { contractor: {
        email: "test@email.com", name: @contractor.name,
        company_name: @contractor.company_name,
        number: "07111000111", town: @contractor.town } }
    end

    assert_redirected_to contractor_url(@contractor)
  end

  test "should redirect to existing contractor if email is the same" do
    assert_no_difference("Contractor.count") do
      post contractors_url, params: { contractor: {
        email: @contractor.email, name: @contractor.name,
        company_name: @contractor.company_name,
        number: "07123000123", town: @contractor.town } }
    end

    assert_redirected_to contractor_url(@contractor)
  end

  test "should show contractor" do
    get contractor_url(@contractor)
    assert_response :success
  end

  test "should get edit" do
    get edit_contractor_url(@contractor)
    assert_response :success
  end

  test "should update contractor" do
    patch contractor_url(@contractor), params: { contractor: {
      email: @contractor.email, name: @contractor.name,
      company_name: @contractor.company_name,
      number: "07111000112", town: @contractor.town } }
    assert_redirected_to contractor_url(@contractor)
  end
end
