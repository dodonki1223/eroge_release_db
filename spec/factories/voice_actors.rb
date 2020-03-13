# frozen_string_literal: true

FactoryBot.define do
  factory :voice_actor do
    sequence(:name) { |n| "Name-#{n}" }
  end
end
