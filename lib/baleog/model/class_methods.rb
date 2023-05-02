# frozen_string_literal: true

class Baleog
  class Model
    module ClassMethods
      def fields(*field_names)
        Builder.build(self) { add_fields(field_names) }
      end

      def field(field_name)
        Builder.build(self) { add_field(field_name) }
      end

      def from(value)
        return unless value

        hash = value.is_a?(String) ? JSON.parse(value) : value

        return hash.map { |h| from(h) } if hash.is_a?(Array)

        new(hash)
      end
    end
  end
end
