# frozen_string_literal: true

module Baleog
  class Model
    # @api private
    # @author darthjee
    #
    # Builder responsible for adding methods to {Model}
    class Builder < Sinclair
      # (see Model.fields)
      def add_fields(field_names)
        field_names.each do |field_name|
          add_field(field_name)
        end
      end

      # (see Model.field)
      def add_field(field_name, key: field_name, cast: nil)
        name = key.to_s
        caster = ValueWrapper.caster_for(cast)

        FieldBuilder.add_methods(
          builder: self,
          field_name: field_name,
          key: name,
          caster: caster,
          klass: cast
        )
      end
    end
  end
end
