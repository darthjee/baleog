# frozen_string_literal: true

require 'sinclair'

# @api public
# @author darthjee
#
# Module responsible for building clients
#
# This module is the entrypoint when building Baelog clients
module Baleog
  autoload :VERSION, 'baleog/version'

  autoload :ClassBuildable, 'baleog/class_buildable'
  autoload :ClassBuilder,   'baleog/class_builder'
  autoload :Client,         'baleog/client'
  autoload :Endpoint,       'baleog/endpoint'
  autoload :Model,          'baleog/model'

  extend ClassBuildable

  build_from(Model)
  build_with(Model)
  build_with(Client)
end
