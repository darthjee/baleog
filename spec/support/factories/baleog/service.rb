# frozen_string_literal: true

FactoryBot.define do
  factory :baleog_service, class: 'Baleog::Service' do
    skip_create

    initialize_with do
      service_class.new(**service_attributes)
    end

    service_class { Baleog::Endpoint }

    service_attributes do
      {
        base_url: base_url
      }
    end

    sequence(:base_url) { "http://someservice#{n}" }
  end
end
