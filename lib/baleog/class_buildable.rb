# frozen_string_literal: true

module Baleog
  module ClassBuildable
    def build_from(base_class)
      @class_builder = ClassBuilder.new(base_class)
    end

    delegate :build, :build_with, to: :class_builder

    private

    def class_builder
      @class_builder ||= ClassBuilder.new(self)
    end
  end
end
