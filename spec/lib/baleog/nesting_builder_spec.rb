# frozen_string_literal: true

require 'spec_helper'

xdescribe Baleog::NestingBuilder do
  let(:klass) { NestingClasses }

  describe '.with_nesting' do
    it 'adds a class to be copied on inheritance' do
      expect { 1 + 1 }
        .to change { Class.new(NestingClasses)::InnerClass }
    end
  end
end
