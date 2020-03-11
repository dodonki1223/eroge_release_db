# frozen_string_literal: true

FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "brand_name_#{n}" }
    url { 'http://example.com' }
  end
end
