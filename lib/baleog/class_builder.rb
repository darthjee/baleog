# frozen_string_literal: true

require 'sinclair'

module Baleog
  class ClassBuilder
    def initialize(base_class)
      @base_class = base_class
    end

    def build
      hooks = after_build

      new_class.tap do |mod|
        hooks.each do |name, block|
          mod.const_set(name, block.call)
        end
      end
    end

    def build_with(name, &block)
      after_build[name] = block
    end

    private

    attr_reader :base_class

    def new_class
      return base_class.new if module?

      Class.new(base_class)
    end

    def after_build
      @after_build ||= {}
    end

    def module?
      base_class == Module
    end
  end
end
