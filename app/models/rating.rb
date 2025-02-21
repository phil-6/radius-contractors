class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :contractor

  validates :contractor_id, uniqueness: { scope: :user_id }
  validate :job_exists_between_user_and_contractor

  private

  def job_exists_between_user_and_contractor
    unless Job.exists?(user_id: user_id, contractor_id: contractor_id)
      errors.add(:base, "You must add a job for this contactor before you can add a rating.")
    end
  end
end
