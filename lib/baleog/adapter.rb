# frozen_string_literal: true

module Baleog
  module Adapter
    autoload :Faraday, 'baleog/adapter/faraday' 

    class << self
      def adapter(name)
        adapters[name.to_sym].constantize
      end

      def adapters
        @adapters ||= {
          faraday: 'Baleog::Adapter::Faraday'
        }
      end
    end
  end
end
