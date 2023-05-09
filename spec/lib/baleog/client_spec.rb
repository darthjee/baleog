# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client do
  let(:client_class) { Class.new(described_class) }

  describe 'inheritance' do
    it 'builds a nested model class' do
      expect(client_class::Model.superclass)
        .to eq(described_class::Model)
    end

    it 'builds a nested value wrapper class' do
      expect(client_class::Model::ValueWrapper.superclass)
        .to eq(described_class::Model::ValueWrapper)
    end
  end
end
