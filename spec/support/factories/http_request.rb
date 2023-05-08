# frozen_string_literal: true

FactoryBot.define do
  factory :http_request, class: 'WebMock::RequestStub' do
    skip_create

    initialize_with do
      webmock_registry
        .register_request_stub(stubbed_request)
        .with(headers: base_headers.merge(request_headers), body: request_body)
        .to_return(status: response_status, body: response_body)
    end

    transient do
      webmock_registry { WebMock::StubRegistry.instance }
      stubbed_request  { WebMock::RequestStub.new(http_method, url) }
      http_method      { :get }

      url do
        [
          base_url.gsub(%r{/$}, ''),
          path.gsub(%r{^/}, '')
        ].join('/')
      end

      base_headers do
        {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.4'
        }
      end

      base_url          { 'http://server.com' }
      path              { '/path' }
      request_headers   { {} }
      request_body      { nil }
      response_status   { 200 }
      response          { {} }
      response_body     { response.to_json }
    end
  end
end
