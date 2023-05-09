# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Adapters do
  describe '.adapter' do
    let(:name) { :faraday }

    context 'when the the adapter has been registered already' do
      it 'returns the registered adapter' do
        expect(described_class.adapter(name))
          .to eq(Baleog::Adapters::Faraday)
      end

      context 'when the adapter has not been loaded so far' do
        let(:name) { :my_first_adapter }

        before do
          described_class.with_adapter(
            name, file: '/home/app/app/spec/not_loaded/adapters/my_first_adapter'
          )
        end

        it 'returns the registered adapter' do
          expect { described_class.adapter(name) }
            .to change { Baleog::Adapters.const_defined?(:MyFirstAdapter) }
            .from(false).to(true)
        end
      end
    end
  end
end
