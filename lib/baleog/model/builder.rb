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
        cast_class = cast

        add_method(field_name) do
          caster.cast(@hash[name], klass: cast_class)
        end

        add_method("#{field_name}=") do |value|
          @hash[name] = value
        end
      end
    end
  end
end
