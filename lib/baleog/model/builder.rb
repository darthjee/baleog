# frozen_string_literal: true

class Baleog
  class Model
    class Builder < Sinclair
      def add_fields(field_names)
        field_names.each do |field_name|
          add_field(field_name)
        end
      end

      def add_field(field_name)
        name = field_name.to_s

        add_method(field_name) do
          @hash[name]
        end

        add_method("#{field_name}=") do
        end
      end
    end
  end
end
