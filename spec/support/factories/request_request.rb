# frozen_string_literal: true

FactoryBot.define do 
  factory :request_request, class: 'WebMock::RequestStub', parent: :http_request do
    transient do
      request  { nil }
      endpoint { request.endpoint }

      service     { endpoint.service }
      base_url    { service.base_url }
      path        { endpoint.path }
      http_method { endpoint.http_method }
      model       { endpoint.model }
    end
  end
end
