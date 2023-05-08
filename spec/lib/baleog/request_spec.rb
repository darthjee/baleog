# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Request do
  subject(:request) do
    create(:baleog_request)
  end

  let(:model_class)     { Person }
  let(:person)          { build(:model_person, **person_hash) }
  let(:person_hash)     { { name: 'Some Name', age: 22 } }
  let(:response_status) { 200 }

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
  end
end
