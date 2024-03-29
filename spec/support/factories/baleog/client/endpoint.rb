# frozen_string_literal: true

FactoryBot.define do
  factory :baleog_endpoint, class: 'Baleog::Client::Endpoint' do
    skip_create

    initialize_with do
      endpoint_class.new(**endpoint_attributes)
    end

    transient do
      endpoint_class { Baleog::Client::Endpoint }

      endpoint_attributes do
        {
          service: service,
          path: path,
          http_method: http_method,
          model: model
        }
      end

      service     { create(:baleog_service) }
      path        { '/some_path' }
      http_method { :get }
      model       { nil }
    end
  end
end
