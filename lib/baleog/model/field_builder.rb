# frozen_string_literal: true

module Baleog
  class Model
    # @api private
    # @author darthjee
    #
    # Class responsible for building methods for each field
    #
    # Both the +reader+ and the +writter+ are added
    class FieldBuilder < Sinclair::Model
      initialize_with(:builder, :options, writter: false)

      # (see #add_method)
      #
      # Adds the methods to the builder
      #
      # @overload self.add_methods(builder:, field_name:, key:, caster:, klass:)
      #   @param builder [Model::Builder] Builder that will receive the
      #     methods definition
      #   @param field_name [Symbol] name of the method/attribute
      #   @param key [String] key to be access in the +@hash+
      #   @param klass [Class,Symbol] Class to be used when wrapping the value
      #
      # @return [Array<MethodDefinition>]
      def self.add_methods(**attributes)
        new(**attributes).add_methods
      end

      # Adds the methods to the builder
      #
      # @return [Array<MethodDefinition>]
      def add_methods
        add_reader
        add_writter
      end

      private

      # @method add_method
      # @api private
      # @private
      #
      # Add a method definition
      #
      # @return [Array<MethodDefinition>]
      delegate :add_method, to: :builder

      delegate :field_name, :key_name, :klass, to: :options

      # Adds a the reader for the field
      #
      # @return [Array<MethodDefinition>]
      def add_reader
        kaster = caster
        key = key_name
        klazz = klass

        add_method(field_name) do
          kaster.cast(self[key], klass: klazz)
        end
      end

      # Adds a the writter for the field
      #
      # @return [Array<MethodDefinition>]
      def add_writter
        key = key_name

        add_method("#{field_name}=") do |value|
          self[key] = value
        end
      end

      # Caster for casting the value
      #
      # The caster is based in the klasss as key
      #
      # @return Sinclair::Caster
      def caster
        ValueWrapper.caster_for(klass)
      end
    end
  end
end
