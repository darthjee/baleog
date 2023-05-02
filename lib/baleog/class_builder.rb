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
      new_class.tap(&block)
    end

    private

    attr_reader :base_class

    def new_class
      return base_class.new if module?
      Class.new(base_class)
    end

    def module?
      base_class == Module
    end
  end
end
