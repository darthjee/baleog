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
      # @overload self.add_methods(builder:, options:)
      #   @param builder [Model::Builder] Builder that will receive the
      #     methods definition
      #   @param options [FieldOptions] field accessing options
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

      # @method field_name
      # @api private
      # @private
      #
      # (see FieldOptions#field_name)
      delegate :field_name, to: :options

      # Adds a the reader for the field
      #
      # @return [Array<MethodDefinition>]
      def add_reader
        opts = options

        add_method(field_name) do
          opts.caster.cast(self[opts.key_name], klass: opts.klass)
        end
      end

      # Adds a the writter for the field
      #
      # @return [Array<MethodDefinition>]
      def add_writter
        opts = options

        add_method("#{field_name}=") do |value|
          self[opts.key_name] = value
        end
      end
    end
  end
end
