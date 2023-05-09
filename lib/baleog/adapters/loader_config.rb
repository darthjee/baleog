# frozen_string_literal: true

module Baleog
  module Adapters
    # @api private
    # @author darthjee
    #
    # Class holding the configuration for on adapter
    #
    # This is used so that the adapters are only loaded
    # into memory upon demand
    class LoaderConfig < Sinclair::Model
      initialize_with(:name, { file: nil, klass: nil }, **{})

      # @method initialize(name:, file: nil, klass: nil)
      # @api private
      #
      # @param name [Symbol] the name of the adapter
      # @param file [String] file to be required when loading the adapter.
      #
      #   when omitted, no file is required and the adapter is considered
      #   already loaded
      # @param klass [String] Name of the class to be returned after
      #   the file is loaded
      #
      #   When omitted klass is infered from the adapter name, under
      #   {Baleog::Adapters}
      #
      # @return [Class<Adapters::Base>]

      # @method name
      # @api private
      #
      # Name of the adapter
      #
      # @return [Symbol]

      # @method file
      # @api private
      #
      # file to be required when loading the adapter.
      #
      # when omitted, no file is required and the adapter is considered
      # already loaded
      #
      # @return [String]

      # @method klass
      # @api private
      #
      # Name of the class to be returned after  the file is loaded
      #
      # When omitted klass is infered from the adapter name, under
      # {Baleog::Adapters}
      #
      # @return [String]

      # Class of the adapter
      #
      # If the class has not been loaded yet, the required file
      # will be loaded, and the constant will be requested
      #
      # @return [Class<Adapters::Base>]
      def adapter_class
        @adapter_class ||= load_class
      end

      def load_class
        require file if file
        adapter_class_name.constantize
      end

      def adapter_class_name
        return klass if klass

        "Baleog::Adapters::#{name.to_s.camelize}"
      end
    end
  end
end
