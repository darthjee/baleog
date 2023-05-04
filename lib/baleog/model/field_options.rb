# frozen_string_literal: true

module Baleog
  class Model
    class FieldOptions < Sinclair::Options
      with_options(:field_name, :key, :cast)

      def klass
        cast
      end
    end
  end
end
