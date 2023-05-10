# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Adapters::Base do
  subject(:adapter) { adapter_class.new(request: request) }

  let(:adapter_class) { described_class }
  let(:request)       { create(:baleog_request) }

  describe '.call' do
    context 'when the class has not been implemented yet' do
      it do
        expect { adapter_class.call(request) }
          .to raise_error(NotImplementedError)
      end
    end

    context 'when the class has been implemented' do
      let(:adapter_class) do
        Class.new(described_class) do
          def call
            request.url
          end
        end
      end

      before do
        allow(request).to receive(:url)
      end

      it 'runs the code inside the call method' do
        adapter_class.call(request)

        expect(request).to have_received(:url)
      end
    end
  end

  describe '#call' do
    context 'when the class has not been implemented yet' do
      it do
        expect { adapter.call }.to raise_error(NotImplementedError)
      end
    end
  end
end
