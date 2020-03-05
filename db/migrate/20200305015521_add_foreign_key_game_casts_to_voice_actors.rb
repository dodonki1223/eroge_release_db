class AddForeignKeyGameCastsToVoiceActors < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :game_casts, :voice_actors
  end
end
