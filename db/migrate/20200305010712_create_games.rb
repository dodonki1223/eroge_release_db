class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title, null: false, index: { unique: true }
      t.integer :brand_id, null: false, index: true
      t.date :date, null: false, index: true

      t.timestamps null: false
    end
  end
end
