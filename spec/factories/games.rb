# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    sequence(:title) { |n| "Game-#{n}" }
    date { Date.current }

    association :brand, factory: [:brand]
  end
end
