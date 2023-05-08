# frozen_string_literal: true

FactoryBot.define do 
  factory :baleog_endpoint, class: 'Baleog::Endpoint' do
    skip_create

    service     { create(:baleog_service) }
    path        { '/some_path' }
    http_method { :get }
    model       { nil }
  end
end
