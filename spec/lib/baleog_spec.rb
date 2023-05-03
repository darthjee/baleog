# frozen_string_literal: true

require 'spec_helper'

describe Baleog do
  describe '.old_build' do
    it do
      expect(described_class.old_build).to be_a(Module)
    end

    it 'add base model' do
      expect(described_class.old_build::Model < described_class::Model)
        .to be_truthy
    end

    it 'add client' do
      expect(described_class.old_build::Client < described_class::Client)
        .to be_truthy
    end
  end
end
