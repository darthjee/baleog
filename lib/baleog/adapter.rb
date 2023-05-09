# frozen_string_literal: true

module Baleog
  module Adapter
    class << self
      def adapter(name)
        require adapters[name.to_sym]
        "Baleog::Adapter::#{name.to_s.camelize}".constantize
      end

      def adapters
        @adapters ||= {
          faraday: 'baleog/adapter/faraday'
        }
      end
    end
  end
end
