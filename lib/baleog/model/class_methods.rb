# frozen_string_literal: true

module Baleog
  class Model
    # @api public
    # @author darthjee
    #
    # Class methods for {Model}
    module ClassMethods
      # (see Model.fields)
      # @see Builder#add_fields
      def fields(*field_names)
        Builder.build(self) { add_fields(field_names) }
      end

      # (see Model.field)
      # @see Builder#add_field
      def field(field_name, **options)
        caster_class = self::ValueWrapper

        Builder.build(self) do
          add_field(
            field_name: field_name,
            caster_class: caster_class,
            **options
          )
        end
      end

      # (see Model.from)
      def from(value)
        return unless value
        return from(JSON.parse(value)) if value.is_a?(String)
        return value.map { |hash| from(hash) } if value.is_a?(Array)

        new(value)
      end
    end
  end
end
