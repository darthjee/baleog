# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  module ClassBuildable
    # @method build
    # @api private
    #
    # Builds a new +Class+ or +Module+
    #
    # @see ClassBuilder#build
    # @return [Class] a new class built (when base class is a +Class+)
    # @return [Module] a new  module built (when base class is a +Module+)

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
