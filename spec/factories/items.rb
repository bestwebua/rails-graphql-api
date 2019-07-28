# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "item-#{n}" }
    user
  end
end
