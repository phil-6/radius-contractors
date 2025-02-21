class Contractor < ApplicationRecord
  belongs_to :added_by, class_name: "User"
  has_many :contractor_trades, dependent: :destroy
  has_many :trades, through: :contractor_trades

  validates :added_by_id, :name, :number, :email, :town, presence: true
  validates :number, uniqueness: true, format: { with: "^(((\+44\s?\d{4}|\(?0\d{4}\)?)\s?\d{3}\s?\d{3})|((\+44\s?\d{3}|\(?0\d{3}\)?)\s?\d{3}\s?\d{4})|((\+44\s?\d{2}|\(?0\d{2}\)?)\s?\d{4}\s?\d{4}))(\s?\#(\d{4}|\d{3}))?$" } # rubocop:disable Layout/LineLength
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
end
