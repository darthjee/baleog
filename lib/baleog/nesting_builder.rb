# frozen_string_literal: true

module Baleog
  module NestingBuilder
    autoload :ClassBuilder, 'baleog/nesting_builder/class_builder'

    def build_nested_classes
      NestingBuilder::ClassBuilder.build(self, :Model)
      NestingBuilder::ClassBuilder.build(self::Model, :ValueWrapper)
    end
  end
end
