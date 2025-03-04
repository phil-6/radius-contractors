class Contractor < ApplicationRecord
  include PgSearch::Model
  belongs_to :added_by, class_name: "User"
  belongs_to :updated_by, class_name: "User", optional: true
  has_many :contractor_trades, dependent: :destroy
  has_many :trades, through: :contractor_trades
  accepts_nested_attributes_for :contractor_trades, allow_destroy: true

  has_many :jobs, dependent: :restrict_with_exception
  has_many :customers, -> { distinct }, through: :jobs, source: :user
  has_many :ratings, dependent: :restrict_with_exception

  before_validation :normalize_blank_values

  validates :name, :number, :town, presence: true
  validates :number, uniqueness: true, format: { with: /\A(?:0|\+?44)(?:\d\s?){9,10}\z/ }
  validates :email, uniqueness: true, allow_nil: true, format: { with: Devise.email_regexp }

  pg_search_scope :search,
                  against: %i[name company_name number email],
                  using: {
                    tsearch: { prefix: true },
                    trigram: { only: :email, threshold: 0.2 }
                  }

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

  private

  def normalize_blank_values
    attributes.each do |column, value|
      self[column] = nil if value.blank?
    end
  end
end
