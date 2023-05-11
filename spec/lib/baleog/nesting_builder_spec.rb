# frozen_string_literal: true

require 'spec_helper'

describe Baleog::NestingBuilder do
  let(:klass) { Class.new(NestingClasses) }

  describe '.with_nesting' do
    it 'adds a class to be copied on inheritance' do
      expect { klass.with_nesting(:InnerClass) }
        .to change { Class.new(klass)::InnerClass }
    end

    context 'after adding nesting build' do
    end
  end
end
