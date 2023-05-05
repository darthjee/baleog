# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Model class representing JSON responses and requests
  #
  # Model is capable of wrapping a JSON nad exposing it's
  # fields using class methods
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'
    autoload :FieldBuilder, 'baleog/model/field_builder'
    autoload :FieldOptions, 'baleog/model/field_options'
    autoload :ValueWrapper, 'baleog/model/value_wrapper'

    extend ClassMethods
    include Sinclair::Comparable

    comparable_by :@hash
    delegate :[], :[]=, to: :@hash

    # @method self.fields(field_names)
    # @api public
    #
    # Add fields to the model
    #
    # @param field_names [Array<Symbol>] fields to be added
    #
    # @see Builder#add_fields
    # @see Builder#add_field
    # @see Model.field
    #
    # @return [Array<Symbol>] added fields

    # @method self.field(field_name)
    # @api public
    #
    # Add field to the model
    #
    # This will add the +reader+ and +setter+
    #
    # @see Builder#add_field
    #
    # @return [Array<Sinclair::MethodDefinition>]

    # @param hash [Hash] hash from request or response
    def initialize(hash = {})
      @hash = hash.stringify_keys
    end
  end
end
