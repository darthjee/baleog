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
        hooks.each do |klass|
          name = klass.name.gsub(/.*::/, '')
          mod.const_set(name, klass.build)
        end
      end
    end

    def build_with(klass)
      after_build << klass
    end

    private

    attr_reader :base_class

    def new_class
      return base_class.new if module?

      Class.new(base_class)
    end

    def after_build
      @after_build ||= Set.new
    end

    def module?
      base_class == Module
    end
  end
end
