class CreateConnections < ActiveRecord::Migration[8.0]
  def change
    create_table :connections do |t|
      t.references :user_a, null: false, foreign_key: { to_table: :users }
      t.references :user_b, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    # Ensure that a connection is always stored in a consistent order
    add_index :connections, [ :user_a_id, :user_b_id ], unique: true
  end
end
