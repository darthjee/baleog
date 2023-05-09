# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Adapters::LoaderConfig do
  describe '#load' do
    subject(:config) { described_class.new(**attributes) }

    let(:name)           { SecureRandom.hex(16) }
    let(:file_path)      { "/path/#{name}" }
    let(:klass)          { klass_constant }
    let(:klass_constant) { "Baleog::Adapters::#{klass_name}" }
    let(:klass_name)     { "my_dapter_#{SecureRandom.hex(16)}".camelize }
    let(:adapter_class)  { Class.new }

    let(:attributes) do
      {
        name: name,
        file: file_path,
        klass: klass
      }.compact
    end

    before do
      allow(config).to receive(:require).with(file_path)
      Baleog::Adapters.const_set(klass_name, adapter_class)
    end

    context 'when defining with the file and class' do
      it 'requires the file' do
        config.load

        expect(config).to have_received(:require).with(file_path)
      end

      it 'returns the class' do
        expect(config.load).to eq(adapter_class)
      end
    end

    context 'when defining with the file' do
      let(:klass)      { nil }
      let(:name)       { "my_dapter_#{SecureRandom.hex(16)}" }
      let(:klass_name) { name.camelize }

      it 'requires the file' do
        config.load

        expect(config).to have_received(:require).with(file_path)
      end

      it 'returns the class' do
        expect(config.load).to eq(adapter_class)
      end
    end
  end
end
