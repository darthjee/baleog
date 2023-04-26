# frozen_string_literal: true

class Baleog
  class Model
    module ClassMethods
      def fields(*field_names)
        field_names.each do |field_name|
          field(field_name)
        end
      end

      def field(field_name)
        name = field_name

        define_method(field_name) do
        end

        define_method("#{field_name}=") do
        end
      end
    end
  end
end

