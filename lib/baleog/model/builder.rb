# frozen_string_literal: true

class Baleog
  class Model
    class Builder < Sinclair
      def add_fields(field_names)
        field_names.each do |field_name|
          add_field(field_name)
        end
      end

      def add_field(field_name, key: field_name)
        name = key.to_s

        add_method(field_name) do
          @hash[name]
        end

        add_method("#{field_name}=") do |value|
          @hash[name] = value
        end
      end
    end
  end
end
