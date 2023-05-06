# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Request do
  subject(:request) do
    described_class.new(endpoint: endpoint)
  end

  let(:model_class) { Person }
  let(:person)      { build(:model_person, **person_hash) }
  let(:person_hash) { { name: 'Some Name', age: 22 } }

  let(:http_method)     { :get }
  let(:http_path)       { '/some_path' }
  let(:response_status) { 200 }
  let(:endpoint) do
    Baleog::Endpoint.new(
      http_method: http_method, path: http_path,
      service: service, model: model_class
    )
  end

  let(:base_url) { 'http://some_service.com' }
  let(:service) do
    Baleog::Service.new(base_url: base_url)
  end

  describe '#call' do
    let(:url) { "#{base_url}#{http_path}" }

    let!(:http_request) do
      create(
        :http_request,
        base_url: base_url, path: http_path, response: person,
        http_method: http_method, response_status: response_status
      ) 
    end

    context 'when it is a get request' do
      it 'performs a request' do
        request.call

        expect(http_request).to have_been_requested
      end

      it do
        expect(request.call.object).to be_a(model_class)
      end

      it 'wraps response with the class' do
        expect(request.call.object).to eq(person)
      end
    end
  end
end
