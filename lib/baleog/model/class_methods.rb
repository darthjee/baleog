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
    end
  end
end
