# frozen_string_literal: true

module Baleog
  class Model
    class ValueWrapper < Sinclair::Caster
      master_caster!

      def self.build
        OldClassBuilder.build(self) {}
      end

      cast_with(:string, :to_s)
      cast_with(String, :to_s)
      cast_with(:integer, :to_i)
      cast_with(Integer, :to_i)
      cast_with(:float, :to_f)
      cast_with(Float, :to_f)

      cast_with(Baleog::Model) do |value, klass:|
        klass.new(value)
      end
    end
  end
end
