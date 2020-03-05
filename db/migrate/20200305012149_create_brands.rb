# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :url

      t.timestamps null: false
    end
  end
end
