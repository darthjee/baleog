# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client do
  describe '.old_build' do
    it do
      expect(described_class.old_build < described_class).to be_truthy
    end
  end
end
