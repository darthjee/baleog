# frozen_string_literal: true

class Baleog
  class Model
    class Builder < Sinclair
      def add_fields(field_names)
        field_names.each do |field_name|
          add_field(field_name)
        end
      end

      def add_field(field_name, alias_name: field_name)
        name = field_name.to_s

        add_method(alias_name) do
          @hash[name]
        end

        add_method("#{alias_name}=") do |value|
          @hash[name] = value
        end
      end
    end
  end
end
