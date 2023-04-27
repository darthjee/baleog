# frozen_string_literal: true

class Baleog
  class Model
    module ValueWrapper
      class << self
        def wrap(value, klass)
          case klass
          when :string
            value.to_s
          when :integer
            value.to_i
          when :float
            value.to_f
          else
            value
          end
        end
      end
    end
  end
end
