# frozen_string_literal: true

module Baleog
  class Model
    # @api private
    # @author darthjee
    #
    # Options for creating field methods
    #
    # @see Baleog::Model.field Baleog::Model.field
    class FieldOptions < Sinclair::Options
      with_options(:field_name, :key, :cast)

      # @method field_name
      # @api private
      #
      # Name of the method to be created
      #
      # @return [Symbol]

      # @method key
      # @api private
      #
      # Custom key to be used when accessing the +@hash+
      #
      # @return [Symbol,String]

      # @method cast
      # @api private
      #
      # Option for casting the value
      #
      # @see Baleog::Model::ValueWrapper
      # @return [ValueWrapper]

      # Class used to wrap the value form hash
      #
      # @return [Class]
      def klass
        return cast if cast.is_a?(Class)

        cast.constantize
      rescue NameError
        cast&.to_sym
      end

      # Key to be used when accessing the value in the hash
      #
      # @return [String]
      def key_name
        (key || field_name).to_s
      end

      # Caster for casting the value
      #
      # The caster is based in the klasss as key
      #
      # @return Sinclair::Caster
      def caster
        @caster ||= ValueWrapper.caster_for(klass)
      end
    end
  end
end
