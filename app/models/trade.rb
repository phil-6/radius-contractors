class Trade < ApplicationRecord
  has_many :contractor_trades, dependent: :destroy
  has_many :contractors, through: :contractor_trades

  validates :name, presence: true, uniqueness: true
end
