class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contractor, null: false, foreign_key: true
      t.text :description
      t.string :status
      t.string :town
      t.date :start_date
      t.date :end_date
      t.float :cost
      t.text :review

      t.timestamps
    end
  end
end
