# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
  end
end
