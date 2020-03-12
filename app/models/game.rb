# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :brand

  validates :title, presence: { message: 'タイトルは空で登録できません' }, uniqueness: { message: '同じタイトルのゲームは登録できません' }
  validates :brand_id, presence: { message: 'ブランドIDは空で登録できません' }
  validates :date, presence: { message: '発売日は空で登録できません' }
end
