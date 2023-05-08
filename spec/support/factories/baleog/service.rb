# frozen_string_literal: true

FactoryBot.define do 
  factory :baleog_service, class: 'Baleog::Service' do
    sequence(:base_url) { "http://someservice#{n}" }
  end
end
