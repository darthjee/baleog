# frozen_string_literal: true

class Baleog
  class Model
    class Builder < Sinclair
      def add_field(field_name)
        add_method(field_name) do
        end

        add_method("#{field_name}=") do
        end
      end
    end
  end
end
