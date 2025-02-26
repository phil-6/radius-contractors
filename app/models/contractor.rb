class Contractor < ApplicationRecord
  belongs_to :added_by, class_name: "User"
  has_many :contractor_trades, dependent: :destroy
  has_many :trades, through: :contractor_trades
  accepts_nested_attributes_for :contractor_trades, allow_destroy: true

  has_many :jobs, dependent: :restrict_with_exception
  has_many :customers, -> { distinct }, through: :jobs, source: :user
  has_many :ratings, dependent: :restrict_with_exception

  validates :added_by_id, :name, :number, :town, presence: true
  validates :number, uniqueness: true, format: { with: %r{\A(?:0|\+?44)(?:\d\s?){9,10}\z} }
  validates :email, uniqueness: true, allow_nil: true, format: { with: Devise.email_regexp }

  def viewable_jobs(user)
    jobs.where(user_id: user.connected_user_ids_and_self)
  end

  def viewable_customers(user)
    customers.where(id: user.connected_user_ids_and_self)
  end

  def jobs_for_customer(user)
    jobs.where(user_id: user.id)
  end

  def viewable_ratings(user)
    ratings.where(user_id: user.connected_user_ids_and_self)
  end

  def average_rating(user)
    viewable_ratings(user).average(:overall_rating)
  end
end
