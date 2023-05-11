# frozen_string_literal: true

require 'spec_helper'

fdescribe Baleog::Client::Response do
  subject(:response) do
    described_class.new(request: request, response: adapter_response)
  end

  let(:request)  { create(:baleog_request, endpoint: endpoint) } 
  let(:endpoint) { create(:baleog_endpoint, model: model) } 
  let(:person)   { create(:model_person) } 
  let(:body)     { person.to_json }
  let(:status)   { 200 }
  let(:model)    { nil }

  let(:adapter_response) do
    instance_double(
      Baleog::Adapters::Response, body: body, status: :status
    )
  end

  describe '#parsed_body' do
    it 'parses the jason into a hash' do
      expect(response.parsed_body).to eq(person.as_json)
    end
  end

  describe '#object' do
    context 'when model has not been defined' do
      it do
        expect(response.object).to be_a(Hash)
      end
    end

    context 'when model has been defined' do
      let(:model) { Person }

      it do
        expect(response.object).to be_a(model)
      end
    end
  end
end
