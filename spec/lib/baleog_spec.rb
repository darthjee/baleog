# frozen_string_literal: true

require 'spec_helper'

describe Baleog do
  describe '.build' do
    it do
      expect(described_class.build).to be_a(Module)
    end

    it 'add base model' do
      expect(described_class.build::Model < described_class::Model).to be_truthy
    end
  end
end
