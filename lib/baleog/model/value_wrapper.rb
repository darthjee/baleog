# frozen_string_literal: true

class Baleog
  class Model
    module ValueWrapper
      class << self
        def with_wrapper(key, &block)
          wrappers[key] = block
        end

        def wrap(value, klass)
          return wrapped(klass, value) if wrapper_defined?(klass)

          value
        end

        private

        def wrapped(key, value)
          wrappers[key].call(value)
        end

        def wrappers
          @wrappers ||= {}
        end

        def wrapper_defined?(key)
          wrappers.key?(key)
        end
      end

      with_wrapper(:string, &:to_s)
      with_wrapper(:integer, &:to_i)
      with_wrapper(:float, &:to_f)
    end
  end
end
