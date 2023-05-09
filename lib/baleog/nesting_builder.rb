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

    def inherited(child)
      complete_nesting_map.each do |name|
        NestingBuilder::ClassBuilder.build(child, name)
      end
    end

    def complete_nesting_map
      return nesting_map unless superclass.try(:nesting_map)

      nesting_map + superclass.nesting_map
    end

    def nesting_map
      @nesting_map ||= Set.new
    end

    def with_nesting(name)
      nesting_map << name
    end
  end
end
