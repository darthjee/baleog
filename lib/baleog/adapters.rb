# frozen_string_literal: true

module Baleog
  module Adapters
    autoload :LoaderConfig, 'baleog/adapters/loader_config'

    class << self
      def adapter(name)
        adapters[name.to_sym].load
      end

      def adapters
        @adapters ||= {}
      end

      def with_adapter(name, **options)
        adapters[name] = Adapters::LoaderConfig.new(name: name, **options)
      end
    end

    with_adapter(:faraday, file: 'baleog/adapters/faraday')
  end
end
