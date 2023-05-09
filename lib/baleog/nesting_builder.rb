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

    # Method called when inheriting
    #
    # This hook is called whenever a class
    # extending NestingBuilder is inherited
    #
    # From all the {#with_nesting hooks},
    # a new child class will be created
    #
    # @see NestingBuilder::ClassBuilder
    # @return (see #complete_nesting_list)
    def inherited(child)
      complete_nesting_list.each do |name|
        NestingBuilder::ClassBuilder.build(child, name)
      end
    end

    # Complete list of classes nested classes to be generated
    #
    # @return (see #nesting_list)
    def complete_nesting_list
      return nesting_list unless superclass.try(:nesting_list)

      nesting_list + superclass.nesting_list
    end

    # List of nesting classes to be created
    #
    # @return [Set<Symbol>]
    def nesting_list
      @nesting_list ||= Set.new
    end

    # (see Baleog::Client.with_nesting)
    def with_nesting(name)
      nesting_list << name
    end
  end
end
