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
      initialize_with(
        :builder, :field_name, :caster, :key, :klass, writter: false
      )

      def self.add_methods(**attributes)
        new(**attributes).add_methods
      end

      delegate :add_method, to: :builder

      def add_methods
        add_reader
        add_writter
      end

      private

      def add_reader
        kaster = caster
        key_name = key
        klazz = klass

        add_method(field_name) do
          kaster.cast(self[key_name], klass: klazz)
        end
      end

      def add_writter
        key_name = key

        add_method("#{field_name}=") do |value|
          self[key_name] = value
        end
      end
    end
  end
end
