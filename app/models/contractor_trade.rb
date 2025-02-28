class ContractorTrade < ApplicationRecord
  belongs_to :contractor
  belongs_to :trade
end
