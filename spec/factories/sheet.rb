# frozen_string_literal: true

FactoryBot.define do
  factory :sheet do
    sequence(:column) { |n| n }
    sequence(:row) { 'a' }
  end
end
