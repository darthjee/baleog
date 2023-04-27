# frozen_string_literal: true

class Baleog
  class Model
    module ValueWrapper
      class << self
        def wrappers
          @wrappers ||= {}
        end

        def with_wrapper(key, &block)
          wrappers[key] = block
        end

        def wrap(value, klass)
          return wrappers[klass].call(value) if wrappers[klass]

          value
        end
      end

      with_wrapper(:string, &:to_s)
      with_wrapper(:integer, &:to_i)
      with_wrapper(:float, &:to_f)
    end
  end
end
