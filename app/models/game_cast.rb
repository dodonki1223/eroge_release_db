# frozen_string_literal: true

class GameCast < ApplicationRecord
  belongs_to :voice_actor
  belongs_to :game

  validates :game_id, presence: { message: 'ゲームIDは空で登録できません' }
  validates :voice_actor_id, presence: { message: '声優IDは空で登録できません' }
end
