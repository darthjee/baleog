# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  #
  # Module responsible for loading adapters
  module Adapters
    autoload :LoaderConfig, 'baleog/adapters/loader_config'

    class << self
      def adapter(name)
        loader_for(name).adapter_class
      end

      def with_adapter(name, **options)
        adapters[name.to_sym] = Adapters::LoaderConfig.new(
          name: name, **options
        )
      end

      private

      def loader_for(name)
        adapters[name.to_sym] || Adapters::LoaderConfig.new(name: name)
      end

      def adapters
        @adapters ||= {}
      end
    end

    with_adapter(:faraday, file: 'baleog/adapters/faraday')
  end
end
