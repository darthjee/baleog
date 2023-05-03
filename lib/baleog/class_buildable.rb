# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  module ClassBuildable
    # Sets the base class when building using {ClassBuilder}
    #
    # @param base_class [Class] The base class to be used, by default, +self+
    #
    # @return [ClassBuilder]
    def build_from(base_class)
      @class_builder = ClassBuilder.new(base_class)
    end

    # @method build
    # @api private
    #
    # Builds a new +Class+ or +Module+
    #
    # @see ClassBuilder#build
    # @return [Class,Module] a new class or module built

    # @method build_with(klass)
    # @api private
    #
    # Attachs a constant build to be build with class building
    #
    # @param klass [Class] class to be attached as a new class built
    #
    # @see ClassBuilder#build_with
    # @return [Set<Class>] all attached classes
    delegate :build, :build_with, to: :class_builder

    private

    # Reader for class builder
    #
    # When it was not initialized, it will be initialized using
    # the class itself as base
    #
    # @see ClassBuilder
    # @return [ClassBuilder]
    def class_builder
      @class_builder ||= ClassBuilder.new(self)
    end
  end
end
