# frozen_string_literal: true

module Baleog
  module Adapter
    class LoaderConfig < Sinclair::Model
      initialize_with(:name, { file: nil, klass: nil }, **{})

      def load
        require file if file
        adapter_class_name.constantize
      end

      def adapter_class_name
        return klass if klass

        "Baleog::Adapter::#{name.to_s.camelize}"
      end
    end
  end
end
