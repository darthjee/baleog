# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Request do
  subject(:request) do
    described_class.new(endpoint: endpoint)
  end

  let(:person) { Person.new(person_hash) }
  let(:person_hash) { { name: 'Some Name', age: 22 } }

  let(:http_method)     { :get }
  let(:http_path)       { '/some_path' }
  let(:response_body)   { person.to_json }
  let(:response_status) { 200 }
  let(:endpoint) do
    Baleog::Endpoint.new(http_method: http_method, path: http_path)
  end

  describe '#call' do
    let!(:http_request) do
      stub_request(http_method, http_path)
        .to_return(status: response_status, body: response_body, headers: {})
    end

    context 'when it is a get request' do
      it 'performs a request' do
        request.call

        expect(http_request).to have_been_requested
      end
    end
  end
end
