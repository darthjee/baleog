# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Adapters do
  describe '.adapter' do
    context 'when the the adapter has been registered already' do
      context 'when passing a symbol' do
        let(:name) { :faraday }

        it 'returns the registered adapter' do
          expect(described_class.adapter(name))
            .to eq(Baleog::Adapters::Faraday)
        end
      end

      context 'when passing a string' do
        let(:name) { 'faraday' }

        it 'returns the registered adapter' do
          expect(described_class.adapter(name))
            .to eq(Baleog::Adapters::Faraday)
        end
      end

      context 'when the adapter has not been loaded so far' do
        let(:name) { :my_first_adapter }
        let(:file_path) do
          "#{Dir.getwd}/spec/not_loaded/adapters/my_first_adapter"
        end

        before do
          described_class.with_adapter(name, file: file_path)
        end

        it 'returns the registered adapter' do
          expect { described_class.adapter(name) }
            .to change { described_class.const_defined?(:MyFirstAdapter) }
            .from(false).to(true)
        end
      end
    end

    context 'when the adapter has not been registered' do
      context 'when the class does not exist' do
        let(:name) { 'some_adapter' }

        it do
          expect { described_class.adapter(name) }
            .to raise_error(NameError)
        end
      end

      context 'when the class does exist and is loaded' do
        let(:name) { 'my_adapter' }

        it do
          expect(described_class.adapter(name))
            .to be(Baleog::Adapters::MyAdapter)
        end
      end

      context 'when passing an already existing class' do
        let(:name) { "my_custom_adapter_#{SecureRandom.hex(10)}".to_sym }
        let(:klass) { Baleog::Adapters::MyAdapter }
        let(:file_path) do
          "#{Dir.getwd}/spec/not_loaded/adapters/my_fake_adapter"
        end

        before do
          allow_any_instance_of(Baleog::Adapters::LoaderConfig)
            .to receive(:require).with(file_path)
                                 .and_raise('not_expected')

          described_class.with_adapter(name, file: file_path, klass: klass)
        end

        it 'does not load the file again' do
          expect { described_class.adapter(name) }
            .not_to raise_error
        end

        it 'returns the class' do
          expect(described_class.adapter(name))
            .to eq(klass)
        end
      end
    end
  end
end
