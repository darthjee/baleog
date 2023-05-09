# frozen_string_literal: true

module Baleog
  module Adapter
    class LoaderConfig < Sinclair::Model
      initialize_with(:name, { file: nil }, **{})

      def load
        require file
      end
    end
  end
end
