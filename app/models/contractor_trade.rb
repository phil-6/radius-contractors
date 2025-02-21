class ContractorTrade < ApplicationRecord
  belongs_to :contractor
  belongs_to :trade

  validates :contractor_id, :trade_id, presence: true
end
