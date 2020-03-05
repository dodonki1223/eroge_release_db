class CreateVoiceActors < ActiveRecord::Migration[6.0]
  def change
    create_table :voice_actors do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
