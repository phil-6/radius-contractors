require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:rating_one)
    sign_in users(:one)
  end

  test "should get index" do
    get ratings_url
    assert_response :success
  end

  test "should get new" do
    get new_rating_url
    assert_response :success
  end

  # TODO: Test that a rating can be created after a job has been added
  # test "should create rating" do
  #   assert_difference("Rating.count") do
  #     post ratings_url, params: { rating: { contractor_id: contractors(:two), communication_rating: @rating.communication_rating, overall_rating: @rating.overall_rating, professionalism_rating: @rating.professionalism_rating, quality_rating: @rating.quality_rating, review: @rating.review, tidiness_rating: @rating.tidiness_rating, user_id: @rating.user_id, value_rating: @rating.value_rating } }
  #   end
  #   assert_redirected_to rating_url(Rating.last)
  # end

  test "should show rating" do
    get rating_url(@rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_rating_url(@rating)
    assert_response :success
  end

  # test "should update rating" do
  #   patch rating_url(@rating), params: { rating: { communication_rating: @rating.communication_rating, contractor_id: @rating.contractor_id, overall_rating: @rating.overall_rating, professionalism_rating: @rating.professionalism_rating, quality_rating: @rating.quality_rating, review: @rating.review, tidiness_rating: @rating.tidiness_rating, user_id: @rating.user_id, value_rating: @rating.value_rating } }
  #   assert_redirected_to rating_url(@rating)
  # end

  test "should destroy rating" do
    assert_difference("Rating.count", -1) do
      delete rating_url(@rating)
    end

    assert_redirected_to ratings_url
  end
end
