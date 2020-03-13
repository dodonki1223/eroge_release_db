# frozen_string_literal: true

class VoiceActor < ApplicationRecord
  validates :name, presence: { message: '声優名は空で登録できません' }, uniqueness: { message: '既に存在している声優名は登録できません' }
end
