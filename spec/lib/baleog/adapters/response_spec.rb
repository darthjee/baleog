# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Adapters::Response do
  subject(:response) { described_class.new(original_response) }

  let(:original_response) do
    instance_double(Faraday::Response, **attributes)
  end

  let(:body)   { SecureRandom.hex(10) }
  let(:status) { Random.rand(200..500) }
  let(:attributes) do
    {
      body: body,
      status: status
    }
  end

  describe '#body' do
    it 'delegates to original response' do
      expect(response.body).to eq(body)
    end
  end

  describe '#status' do
    it 'delegates to original response' do
      expect(response.status).to eq(status)
    end
  end
end
