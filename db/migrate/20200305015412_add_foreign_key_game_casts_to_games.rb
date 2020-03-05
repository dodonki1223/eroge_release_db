class AddForeignKeyGameCastsToGames < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :game_casts, :games
  end
end
