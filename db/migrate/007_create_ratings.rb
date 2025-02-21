class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contractor, null: false, foreign_key: true
      t.text :review
      t.float :overall_rating
      t.float :value_rating
      t.float :communication_rating
      t.float :quality_rating
      t.float :tidiness_rating
      t.float :professionalism_rating

      t.timestamps
    end
    add_index :ratings, [:user_id, :contractor_id], unique: true
  end
end
