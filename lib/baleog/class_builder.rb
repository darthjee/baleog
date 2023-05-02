# frozen_string_literal: true

require 'sinclair'

module Baleog
  class ClassBuilder
    def self.build(base_class, &block)
      new(base_class).build(&block)
    end

    def initialize(base_class)
      @base_class = base_class
    end

    def build(&block)
      base_class.new.tap(&block)
    end

    private

    attr_reader :base_class
  end
end
