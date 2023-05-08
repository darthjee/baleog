# frozen_string_literal: true

FactoryBot.define do 
  factory :baleog_request, class: 'Baleog::Request' do
    skip_create

    endpoint { create(:baleog_endpoint) }
  end
end
