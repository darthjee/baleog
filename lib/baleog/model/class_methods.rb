# frozen_string_literal: true

module Baleog
  class Model
    # @api public
    # @author darthjee
    #
    # Class methods for {Model}
    module ClassMethods
      # (see Builder#add_fields)
      # @see Builder#add_fields
      def fields(*field_names)
        Builder.build(self) { add_fields(field_names) }
      end

      # (see Builder#add_field)
      # @see Builder#add_field
      def field(field_name)
        Builder.build(self) { add_field(field_name) }
      end

      # Creates a new instance of {Model} initializing it from a value
      #
      # @overload self.from(json)
      #   @param json [String] JSON to be parsed in a hash before initialization
      #
      #   When the json represents an Array, an array is returned
      #
      #   @return [Model] Model returned when JSON represents a Hash
      #   @return [Array<Model>] returned when JSON represents an Array
      #
      # @overload self.from(hash)
      #   @param hash [Hash] Hash containing the attributes for the model
      #
      #   @return [Model]
      #
      # @overload self.from(array)
      #   @param hash [Array<Hash>] Array of hashes containing the attributes for the model
      #
      #   @return [Array<Model>]
      #
      # @return [Model]
      def from(value)
        return unless value

        hash = value.is_a?(String) ? JSON.parse(value) : value

        return hash.map { |h| from(h) } if hash.is_a?(Array)

        new(hash)
      end
    end
  end
end
