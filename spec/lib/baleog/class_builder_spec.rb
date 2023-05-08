# frozen_string_literal: true

require 'spec_helper'

describe Baleog::ClassBuilder do
  describe '.build' do
    let(:klass) { Class.new(NestingClass) }

    it 'builds the inner class' do
      expect { described_class.build(klass, :NestedClass, NestingClass::NestedClass) }
        .to change { klass::NestedClass }
    end

    it 'builds the inner class to inherit' do
      described_class.build(klass, :NestedClass, NestingClass::NestedClass)

      expect(klass::NestedClass.superclass).to eq(NestingClass::NestedClass)
    end
  end
end
