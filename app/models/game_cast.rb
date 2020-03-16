# frozen_string_literal: true

class GameCast < ApplicationRecord
  belongs_to :voice_actor
  belongs_to :game

  validates :game_id, presence: { message: 'ゲームIDは空で登録できません' },
                      uniqueness: { scope: :voice_actor_id, message: '既にゲームIDと声優IDの組み合わせが存在しています' }
  validates :voice_actor_id, presence: { message: '声優IDは空で登録できません' }
end
