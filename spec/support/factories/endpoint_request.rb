# frozen_string_literal: true

FactoryBot.define do 
  factory :endpoint_request, class: 'WebMock::RequestStub', parent: :http_request do
    transient do
      endpoint { nil }
    end
  end
end
