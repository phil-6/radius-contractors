class CreateContractorTrades < ActiveRecord::Migration[8.0]
  def change
    create_table :contractor_trades do |t|
      t.references :contractor, null: false, foreign_key: true
      t.references :trade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
