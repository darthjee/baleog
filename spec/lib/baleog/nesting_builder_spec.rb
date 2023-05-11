# frozen_string_literal: true

require 'spec_helper'

describe Baleog::NestingBuilder do
  let(:klass)        { Class.new(parent_class) }
  let(:parent_class) { NestingClasses }
  let(:child_klass)  { Class.new(klass) }

  describe '.with_nesting' do
    it 'adds a class to be copied on inheritance' do
      expect { klass.with_nesting(:InnerClass) }
        .to change { Class.new(klass)::InnerClass }
    end

    it 'does not add a class to be copied on inheritance of superclass' do
      expect { klass.with_nesting(:InnerClass) }
        .not_to change { Class.new(parent_class)::InnerClass }
    end

    it 'adds a class to be copied on inheritance of child class' do
      expect { klass.with_nesting(:InnerClass) }
        .to change { Class.new(child_klass)::InnerClass }
    end

    context 'after adding nesting build' do
      before { klass.with_nesting(:InnerClass) }

      it 'applies inherance on the inner class' do
        expect(Class.new(klass)::InnerClass < NestingClasses::InnerClass)
          .to be_truthy
      end

      it 'applies inherance on the child inner class' do
        expect(Class.new(child_klass)::InnerClass < child_klass::InnerClass)
          .to be_truthy
      end
    end
  end
end
