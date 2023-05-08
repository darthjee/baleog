# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client::Request do
  subject(:request) do
    create(:baleog_request, **request_attributes)
  end

  let(:model_class)     { person.class }
  let(:person)          { build(:model_person) }
  let(:response_status) { 200 }
  let(:http_method)     { :get }
  let(:payload)         { nil }
  let(:request_attributes) do
    {
      endpoint: endpoint_attributes,
      payload: payload
    }
  end
  let(:endpoint_attributes) do
    { model: model_class, http_method: http_method }
  end

  describe '#call' do
    let!(:http_request) do
      create(
        :request_request,
        request: request,
        response: person,
        response_status: response_status
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

    context 'when it is a post request' do
      let(:http_method) { :post }
      let(:payload) do
        person.as_json.tap do |hash|
          hash.delete('id')
        end
      end

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
