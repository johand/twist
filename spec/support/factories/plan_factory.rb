# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    sequence(:amount) { |n| "1#{n}" }
    association :product
  end
end
