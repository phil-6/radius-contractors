class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :contractor

  validates :contractor_id, uniqueness: { scope: :user_id }
  validate :job_exists_between_user_and_contractor

  def from_number_of_jobs
    user.jobs.where(contractor_id:).size
  end

  def rating_quality # rubocop:disable Metrics/MethodLength
    case overall_rating
    when 0..5
      "bad"
    when 5..7.5
      "average"
    when 7.5..8
      "good"
    when 9..10
      "excellent"
    else
      "unknown"
    end
  end

  private

  def job_exists_between_user_and_contractor
    return if Job.exists?(user_id:, contractor_id:)

    errors.add(:base, "You must add a job for this contactor before you can add a rating.")
  end
end
