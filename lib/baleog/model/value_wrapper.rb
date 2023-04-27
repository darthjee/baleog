# frozen_string_literal: true

class Baleog
  class Model
    module ValueWrapper
      class << self
        def with_wrapper(key, &block)
          wrappers[key] = block
        end

        def wrap(value, klass)
          return value unless wrapper_defined?(klass)

          wrapped(klass, value)
        end

        private

        def wrapped(key, value)
          wrappers[key].to_proc.call(value)
        end

        def wrappers
          @wrappers ||= {}
        end

        def wrapper_defined?(key)
          wrappers.key?(key)
        end
      end

      with_wrapper(:string, :to_s)
      with_wrapper(:integer, :to_i)
      with_wrapper(:float, :to_f)
    end
  end
end
