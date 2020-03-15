# frozen_string_literal: true

FactoryBot.define do
  factory :game_cast do
    association :game, factory: [:game]
    association :voice_actor, factory: [:voice_actor]
  end
end
