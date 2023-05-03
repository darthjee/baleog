# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  module ClassBuildable
    def build_from(base_class)
      @class_builder = ClassBuilder.new(base_class)
    end

    # @method build
    # @api private
    #
    # Builds a new +Class+ or +Module+
    #
    # @see ClassBuilder#build
    # @return [Class,Module]

    # @method build_with
    # @api private
    #
    # Attachs a constant build to be build with class building
    #
    # @see ClassBuilder#build_with
    # @return [Class]
    delegate :build, :build_with, to: :class_builder

    private

    def class_builder
      @class_builder ||= ClassBuilder.new(self)
    end
  end
end
