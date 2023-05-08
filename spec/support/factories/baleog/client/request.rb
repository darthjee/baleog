# frozen_string_literal: true

FactoryBot.define do
  factory :baleog_request, class: 'Baleog::Client::Request' do
    skip_create

    initialize_with do
      request_class.new(**request_attributes)
    end

    transient do
      request_class { Baleog::Client::Request }

      request_attributes do
        {
          endpoint: endpoint_object
        }
      end

      endpoint { create(:baleog_endpoint) }

      endpoint_object do
        endpoint.is_a?(Hash) ? create(:baleog_endpoint, **endpoint) : endpoint
      end
    end
  end
end
