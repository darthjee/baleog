# frozen_string_literal: true

module Baleog
  module ClassBuildable
    def build_from(base_class)
      @class_builder = ClassBuilder.new(base_class)
    end

    def build_with(name, &block)
      after_build[name] = block
    end

    def build
      hooks = after_build

      class_builder.build do |mod|
        hooks.each do |name, block|
          mod.const_set(name, block.call)
        end
      end
    end

    private

    def class_builder
      @class_builder ||= ClassBuilder.new(self)
    end

    def after_build
      @after_build ||= {}
    end
  end
end
