# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Module responsible for loading adapters
  module Adapters
    autoload :Base,         'baleog/adapters/base'
    autoload :LoaderConfig, 'baleog/adapters/loader_config'
    autoload :Response,     'baleog/adapters/response'

    class << self
      # @api private
      # Returns the Adapter registered to a name
      #
      # if the adapter has not been registered, the code will
      # try to return +Baleog::Adapters::name.camelize+
      #
      # @param name [Symbol] the registered name
      #
      # @return [Symbol] the name of the adapter
      def adapter(name)
        loaded_adapters[name] ||= load_adapter(name)
      end

      # Register an adapter under a name
      #
      # @overload with_adapter(name, file: nil, klass: nil)
      #   A configuration is stored to be loaded on demand loading the klass
      #   from a file
      #
      #   @param name [Symbol] The adapter name
      #
      #     when klass is omitted, the klass is infered from the name
      #   @param file [String] The file to be loaded (containing the
      #     adapter class definition)
      #
      #     when omitted, no file is loaded
      #
      #   @param klass [String] The name of the class to be returned
      #
      #   @return [Set<Adapters::LoaderConfig>] All registered configurations
      #
      # @overload with_adapter(name, klass: nil)
      #   @param name [Symbol] The adapter name
      #   @param klass [Class<Adapters::Base>] The class of the adapter
      #
      #   No configuration is stored, just a map of a name and a class,
      #   for quick load
      #
      #   @return [Class<Adapters::Base>] the registered class
      def with_adapter(name, file: nil, klass: nil)
        return loaded_adapters[name] = klass if klass&.is_a?(Class)

        adapters_configs[name.to_sym] = Adapters::LoaderConfig.new(
          name: name, file: file, klass: klass
        )
      end

      private

      # @api private
      # @private
      #
      # Map of all adapter classes already loaded
      #
      # @return [Hash<Symbol,Class<Adapters::Base>]
      def loaded_adapters
        @loaded_adapters ||= {}
      end

      # @api private
      # @private
      #
      # Load an adapter class from configuration
      #
      # This is called when the adapter is not found
      # on {#loaded_adapters}
      #
      # @return [Class<Adapters::Base>]
      def load_adapter(name)
        loader_for(name).adapter_class
      end

      # @api private
      # @private
      #
      # Returns a loader for a name
      #
      # When the loader is not found, a default loader
      # is returned
      #
      # The default loader loads no file and infers the class from name
      #
      # @return [Adapters::LoaderConfig]
      def loader_for(name)
        adapters_configs[name.to_sym] || Adapters::LoaderConfig.new(name: name)
      end

      # @api private
      # @private
      #
      # Map of all registered adapters loaders configurations
      #
      # @return [Hash<Symbol,Adapters::LoaderConfig>]
      def adapters_configs
        @adapters_configs ||= {}
      end
    end

    with_adapter(:faraday, file: 'baleog/adapters/faraday')
  end
end
