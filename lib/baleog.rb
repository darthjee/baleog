# frozen_string_literal: true

require 'sinclair'

# @api public
# @author darthjee
module Baleog
  autoload :VERSION, 'baleog/version'

  autoload :ClassBuildable,  'baleog/class_buildable'
  autoload :OldClassBuilder, 'baleog/old_class_builder'
  autoload :Client,          'baleog/client'
  autoload :Endpoint,        'baleog/endpoint'
  autoload :Model,           'baleog/model'

  def self.old_build
    OldClassBuilder.build(Module) do |mod|
      mod.const_set(:Model, Model.old_build)
      mod.const_set(:Client, Client.old_build)
    end
  end
end
