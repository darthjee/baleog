# frozen_string_literal: true

module Baleog
  module NestingBuilder
    def build_nested_classes
      ClassBuilder.build(self, :Model)
      ClassBuilder.build(self::Model, :ValueWrapper)
    end
  end
end
