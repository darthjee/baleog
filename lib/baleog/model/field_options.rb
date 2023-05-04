# frozen_string_literal: true

module Baleog
  class Model
    class FieldOptions < Sinclair::Options
      with_options(:field_name, :key, :cast)

      def klass
        cast
      end

      def key_name
        (key || field_name).to_s
      end
    end
  end
end
