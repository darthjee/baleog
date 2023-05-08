# frozen_string_literal: true

FactoryBot.define do
  factory :baleog_request, class: 'Baleog::Request' do
    skip_create

    initialize_with do
      request_class.new(**request_attributes)
    end

    request_class { Baleog::Request }

    request_attributes do
      {
        endpoint: endpoint
      }
    end

    endpoint { create(:baleog_endpoint) }
  end
end
