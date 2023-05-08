# frozen_string_literal: true

FactoryBot.define do
  factory :model_person, class: 'Person' do
    sequence(:id)   { |n| n }
    sequence(:name) { |n| "Person ###{n}" }
    age             { 20 }
  end
end
