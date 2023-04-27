# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Endpoint do
  subject(:endpoint) { described_class.new(**attributes) }

  let(:path)        { SecureRandom.hex(10) }
  let(:http_method) { described_class::HTTP_METHODS.sample }

  let(:attributes) do
    {
      path: path,
      http_method: http_method
    }.compact
  end

  describe '#path' do
    it 'returns the given path' do
      expect(endpoint.path).to eq(path)
    end
  end

  describe '#http_method' do
    it 'returns the given path' do
      expect(endpoint.http_method).to eq(http_method)
    end

    context 'when http_method is not given' do
      let(:http_method) { nil }

      it 'returns the default path' do
        expect(endpoint.http_method).to eq(:get)
      end
    end
  end
end
