# frozen_string_literal: true

module Baleog
  module Adapter
    autoload :LoaderConfig, 'baleog/adapter/loader_config'

    class << self
      def adapter(name)
        adapters[name.to_sym].load
        "Baleog::Adapter::#{name.to_s.camelize}".constantize
      end

      def adapters
        @adapters ||= {}
      end

      def with_adapter(name, file:)
        adapters[name] = Baleog::Adapter::LoaderConfig.new(name: name, file: file)
      end
    end

    with_adapter(:faraday, file: 'baleog/adapter/faraday')
  end
end
