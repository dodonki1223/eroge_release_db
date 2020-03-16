# frozen_string_literal: true

class AddUniqunessKeyGameCastsToGameIdAndVoiceActorId < ActiveRecord::Migration[6.0]
  def change
    add_index :game_casts, [:game_id, :voice_actor_id], unique: true
  end
end
