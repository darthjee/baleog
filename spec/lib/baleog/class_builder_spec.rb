# frozen_string_literal: true

require 'spec_helper'

describe Baleog::ClassBuilder do
  subject(:builder) { described_class.new(base_class) }

  let(:base_class) { Class.new }

  describe '#build' do
    context 'when base class is a module' do
      let(:base_class) { Module }

      it do
        expect(builder.build).to be_a(Module)
      end
    end

    context 'when base class is a class' do
      it 'returns a class inheriting from base_class' do
        expect(builder.build < base_class).to be_truthy
      end
    end
  end

  describe '#build_with' do
    it 'attachs a nested class to be built' do
      expect { builder.build_with(Baleog::Model) }
        .to change { builder.build.const_defined?(:Model) }
        .from(false)
        .to(true)
    end
  end
end
