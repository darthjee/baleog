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
    # One rule states that, if the class of the wrapping is a Baelog::Model,
    # the value is initalized with {Baleog::Model.from model_class.from}
    #
    # @see /gems/sinclair/1.16.2/Sinclair/Caster Sinclair::Caster
    # @see ValueWrapper.cast_with
    # @see Model.for
    class ValueWrapper < Sinclair::Caster
      master_caster!

      cast_with(:string, :to_s)
      cast_with(String, :to_s)
      cast_with(:integer, :to_i)
      cast_with(Integer, :to_i)
      cast_with(:float, :to_f)
      cast_with(Float, :to_f)

      cast_with(Baleog::Model) do |value, klass:|
        klass.from(value)
      end

      # @method self.caster_for
      # @api public
      #
      # Returns an instance of caster for the provided key
      #
      # When no registered caster is found one is requested for
      # the parent class.
      # If no caster is found, then a default caster is returned
      #
      # The default caster performs no casting returning the value itself
      #
      # @overload caster_for(key)
      #   @param key [Symbol] key where the caster is registered under
      #
      # @overload caster_for(class_key)
      #   @param class_key [Class] Class to used as key in the casters storage
      #
      #   When the +class_key+ does not match the stored key, but
      #   matches a superclass,
      #   the registerd caster is returned.
      #
      # @see https://www.rubydoc.info/gems/sinclair/1.16.2/Sinclair/Caster#caster_for-class_method
      #   Sinclair::Caster.caster_for
      # @see ValueWrapper.cast_with
      #
      # @return [Caster]

      # @method self.cast_with
      # @api public
      #
      # Register a new caster to be used on {Model.field}
      #
      # The caster is used when passing +cast:+ option
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
      #     This will be used as parent class when the calling
      #     {ValueWrapper.caster_for}.
      #   @param method_name [Symbol] method to be called on the
      #     value that is being converted.
      #
      # @overload cast_with(class_key, &block)
      #   @param class_key [Class] class to be used as key.
      #     This will be used as parent class when the calling
      #     {ValueWrapper.caster_for}
      #   @param block [Proc] block to be used when casting the value.
      #
      # @see Model.field
      # @see /gems/sinclair/1.16.2/Sinclair/Caster#cast_with-class_method
      #   Sinclair::Caster.cast_with
      # @return [ValueWrapper] the registered caster
    end
  end
end
