# frozen_string_literal: true

class Baleog
  class Model
    module ValueWrapper
      class << self
        def wrap(value, klass)
          value
        end
      end
    end
  end
end
