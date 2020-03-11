# frozen_string_literal: true

class Brand < ApplicationRecord
  validates :name, presence: { message: 'ブランド名は空で登録できません' }
end
