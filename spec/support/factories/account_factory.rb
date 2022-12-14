# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "Test Account ##{n}" }
    sequence(:subdomain) { |n| "test#{n}" }
    association :owner, factory: :user
  end
end
