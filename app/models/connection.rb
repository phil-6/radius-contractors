class Connection < ApplicationRecord
  belongs_to :user_a, class_name: "User"
  belongs_to :user_b, class_name: "User"

  # Ensure that a connection between the same users is unique
  before_validation :order_users
  validates :user_a_id, uniqueness: { scope: :user_b_id }

  # Custom validation to prevent self-referential connections
  validate :not_self_referential

  private

  def order_users
    errors.add(:base, "A connection must have two users") and return if user_a_id.nil? || user_b_id.nil?
    if user_a_id > user_b_id
      self.user_a_id, self.user_b_id = user_b_id, user_a_id
    end
  end

  def not_self_referential
    errors.add(:base, "Users cannot connect to themselves") if user_a_id == user_b_id
  end
end
