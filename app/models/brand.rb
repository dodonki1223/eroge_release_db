# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :games, dependent: :destroy

  validates :name, presence: { message: 'ブランド名は空で登録できません' },
                   uniqueness: { message: '同じブランド名は登録できません' }
end
