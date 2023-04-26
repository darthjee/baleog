# frozen_string_literal: true

class Baleog
  class Model
    module ClassMethods
      def fields(*field_names)
        Builder.new(self).tap do |builder|
          field_names.each do |field_name|
            builder.add_field(field_name)
          end
        end.build
      end

      def field(field_name)
        Builder.new(self).tap do |builder|
          builder.add_field(field_name)
        end.build
      end
    end
  end
end
