class CreateContractors < ActiveRecord::Migration[8.0]
  def change
    create_table :contractors do |t|
      t.references :added_by, null: false, foreign_key: { to_table: :users }
      t.references :updated_by, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :company_name
      t.string :number, null: false
      t.string :email
      t.string :town, null: false

      t.timestamps
    end
    add_index :contractors, :email, unique: true
    add_index :contractors, :number, unique: true
  end
end
