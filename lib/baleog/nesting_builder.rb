# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  #
  # Module exposing method to build nested classes under it
  #
  # This will ensure that the nested classes are configurable without
  # affecting other clients
  module NestingBuilder
    autoload :ClassBuilder, 'baleog/nesting_builder/class_builder'

    def build_nested_classes
      NestingBuilder::ClassBuilder.build(self, :Model)
      NestingBuilder::ClassBuilder.build(self::Model, :ValueWrapper)
    end
  end
end
