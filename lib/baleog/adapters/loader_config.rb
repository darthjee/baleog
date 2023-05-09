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

      def load
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
