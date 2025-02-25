require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:rating_one)
    @contractor = @rating.contractor
    sign_in users(:one)
  end

  # TODO: Remove this probably
  # test "should get index" do
  #   get ratings_url
  #   assert_response :success
  # end

  test "should get new" do
    get new_contractor_rating_url(@contractor)
    assert_response :success
  end

  # TODO: Test that a rating can be created after a job has been added
  # test "should create rating" do
  #   assert_difference("Rating.count") do
  #     post ratings_url, params: { rating: { communication_rating: @rating.communication_rating, overall_rating: @rating.overall_rating, professionalism_rating: @rating.professionalism_rating, quality_rating: @rating.quality_rating, review: @rating.review, tidiness_rating: @rating.tidiness_rating, value_rating: @rating.value_rating } }
  #   end
  #   assert_redirected_to rating_url(Rating.last)
  # end

  test "should show rating" do
    get contractor_rating_url(@contractor, @rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_contractor_rating_url(@contractor, @rating)
    assert_response :success
  end

  # test "should update rating" do
  #   patch rating_url(@rating), params: { rating: { communication_rating: @rating.communication_rating, overall_rating: @rating.overall_rating, professionalism_rating: @rating.professionalism_rating, quality_rating: @rating.quality_rating, review: @rating.review, tidiness_rating: @rating.tidiness_rating, value_rating: @rating.value_rating } }
  #   assert_redirected_to rating_url(@rating)
  # end

  # TODO: Do we need delete, or just edit?
  test "should destroy rating" do
    assert_difference("Rating.count", -1) do
      delete contractor_rating_url(@contractor, @rating)
    end

    assert_redirected_to contractor_path(@contractor)
  end
end
