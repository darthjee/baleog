# frozen_string_literal: true

module Baleog
  class Client
    class EndpointBuilder < Sinclair
      def initialize(klass, method_name, **options)
        @method_name = method_name
        @options     = options

        super(klass)
      end

      def build
        add_method(method_name) {}

        super
      end

      private

      attr_reader :method_name, :options
    end
  end
end
