class CreateTrades < ActiveRecord::Migration[8.0]
  def change
    create_table :trades do |t|
      t.string :name

      t.timestamps
    end
    add_index :trades, :name, unique: true
  end
end
