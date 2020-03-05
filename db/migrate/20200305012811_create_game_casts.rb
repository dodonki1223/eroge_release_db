# frozen_string_literal: true

class CreateGameCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :game_casts do |t|
      t.integer :game_id, null: false, index: true
      t.integer :voice_actor_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
