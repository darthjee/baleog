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

        add_reader(field_name, name, caster, cast)
        add_writter(field_name, name)
      end

      private

      def add_reader(field_name, key, caster, klass)
        add_method(field_name) do
          caster.cast(@hash[key], klass: klass)
        end
      end

      def add_writter(field_name, key)
        add_method("#{field_name}=") do |value|
          @hash[key] = value
        end
      end
    end
  end
end
