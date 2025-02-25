require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
    @contractor = @job.contractor
    sign_in users(:two)
  end

  # TODO: Remove this probably
  # test "should get index" do
  #   get jobs_url
  #   assert_response :success
  # end

  test "should get new" do
    get new_contractor_job_url(@contractor)
    assert_response :success
  end

  test "should create job" do
    assert_difference("Job.count") do
      post contractor_jobs_url(@contractor), params: { job: { end_date: @job.end_date, review: @job.review, start_date: @job.start_date, status: @job.status, user_id: @job.user_id } }
    end

    assert_redirected_to contractor_url(@contractor)
  end

  test "should show job" do
    get contractor_job_url(@contractor, @job)
    assert_response :success
  end

  test "should get edit" do
    get edit_contractor_job_url(@contractor, @job)
    assert_response :success
  end

  test "should update job" do
    patch contractor_job_url(@contractor, @job), params: { job: { description: @job.description, end_date: @job.end_date, review: @job.review, start_date: @job.start_date, status: @job.status } }
    assert_redirected_to contractor_url(@contractor)
  end

  test "should destroy job" do
    assert_difference("Job.count", -1) do
      delete contractor_job_url(@contractor, @job)
    end

    assert_redirected_to contractor_url(@contractor)
  end
end
