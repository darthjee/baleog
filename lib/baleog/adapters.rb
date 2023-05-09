# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  #
  # Module responsible for loading adapters
  module Adapters
    autoload :Base,         'baleog/adapters/base'
    autoload :LoaderConfig, 'baleog/adapters/loader_config'
    autoload :Response,     'baleog/adapters/response'

    class << self
      def adapter(name)
        loaded_adapters[name] ||= load_adapter(name)
      end

      def with_adapter(name, file: nil, klass: nil)
        return loaded_adapters[name] = klass if klass&.is_a?(Class)

        adapters[name.to_sym] = Adapters::LoaderConfig.new(
          name: name, file: file, klass: klass
        )
      end

      private

      def loaded_adapters
        @loaded_adapters ||= {}
      end

      def load_adapter(name)
        loader_for(name).adapter_class
      end

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
