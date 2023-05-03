# frozen_string_literal: true

module Baleog
  class Model
    # @api public
    # @author darthjee
    #
    # Class responsible to converting values on {Model} methods
    #
    # Whenever a value is read from +Model@hash+ this is converted
    # based on ValueWrapper rules
    #
    # @see https://www.rubydoc.info/gems/sinclair/1.16.2/Sinclair/Caster Sinclair::Caster
    # @see ValueWrapper.cast_with
    class ValueWrapper < Sinclair::Caster
      extend ClassBuildable

      master_caster!

      cast_with(:string, :to_s)
      cast_with(String, :to_s)
      cast_with(:integer, :to_i)
      cast_with(Integer, :to_i)
      cast_with(:float, :to_f)
      cast_with(Float, :to_f)

      cast_with(Baleog::Model) do |value, klass:|
        klass.new(value)
      end

      # @method self.cast_with
      # @api public
      #
      # Register a new caster to be used on {Model.field}
      #   when passing +cast:+ option
      #
      # @overload cast_with(key, method_name)
      #   @param key [Symbol] key where the caster will be store.
      #   @param method_name [Symbol] method to be called on the
      #     value that is being converted
      #
      # @overload cast_with(key, &block)
      #   @param key [Symbol] key where the caster will be store.
      #   @param block [Proc] block to be used when casting the value.
      #
      # @overload cast_with(class_key, method_name)
      #   @param class_key [Class] class to be used as key.
      #     This will be used as parent class when the calling {ValueWrapper.caster_for}.
      #   @param method_name [Symbol] method to be called on the
      #     value that is being converted.
      #
      # @overload cast_with(class_key, &block)
      #   @param class_key [Class] class to be used as key.
      #     This will be used as parent class when the calling {ValueWrapper.caster_for}
      #   @param block [Proc] block to be used when casting the value.
      #
      # @see Model.field
      # @return [ValueWrapper] the registered caster
    end
  end
end
