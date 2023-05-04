# frozen_string_literal: true

require 'spec_helper'

describe Baleog::ClassBuildable do
  let(:klass) do
    Class.new do
      extend Baleog::ClassBuildable
    end
  end

  describe '.build' do
    context 'when base class is a module' do
      let(:klass) do
        Module.new do
          extend Baleog::ClassBuildable

          build_from(Module)
        end
      end

      it do
        expect(klass.build).to be_a(Module)
      end

      it 'Do not returns the same class' do
        expect(klass.build).not_to be(klass)
      end
    end

    context 'when base class is a class' do
      it 'returns a class inheriting from base_class' do
        expect(klass.build < klass).to be_truthy
      end
    end
  end

  describe '.build_with' do
    it 'attachs a nested class to be built' do
      expect { klass.build_with(Baleog::Model) }
        .to change { klass.build.const_defined?(:Model) }
        .from(false)
        .to(true)
    end
  end
end
