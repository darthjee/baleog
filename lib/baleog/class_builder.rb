# frozen_string_literal: true

require 'sinclair'

module Baleog
  # Builder responsible to creating a new +Class+ or +Module+
  #
  # Building starts by creating a new module or a new class
  # inheriting from +base_class+
  #
  # After building it, new constants are created as new classes
  # built from other required classes
  #
  # @see ClassBuildable
  class ClassBuilder
    # @param base_class [Class] The base class to be used
    def initialize(base_class)
      @base_class = base_class
    end

    # (see ClassBuildable#build)
    def build
      hooks = after_build

      new_class.tap do |mod|
        hooks.each do |klass|
          name = klass.name.gsub(/.*::/, '')
          mod.const_set(name, klass.build)
        end
      end
    end

    # (see ClassBuildable#build_with)
    def build_with(klass)
      after_build << klass
    end

    private

    # @attr_reader base_class
    #
    # @return [Class]
    attr_reader :base_class

    # Returns a new instance of +Module+ or +Class+
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
