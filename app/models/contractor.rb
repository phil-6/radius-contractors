class Contractor < ApplicationRecord
  belongs_to :added_by, class_name: "User"
  has_many :contractor_trades, dependent: :destroy
  has_many :trades, through: :contractor_trades

  has_many :jobs, dependent: :restrict_with_exception
  has_many :customers, through: :jobs, source: :user
  has_many :ratings, dependent: :restrict_with_exception

  validates :added_by_id, :name, :number, :email, :town, presence: true
  validates :number, uniqueness: true, format: { with: %r{\A(?:0|\+?44)(?:\d\s?){9,10}\z} }
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
end
