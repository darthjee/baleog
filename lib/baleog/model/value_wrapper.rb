# frozen_string_literal: true

module Baleog
  class Model
    class ValueWrapper < Sinclair::Caster
      master_caster!

      def self.build
        Class.new(self)
      end

      cast_with(:string, :to_s)
      cast_with(String, :to_s)
      cast_with(:integer, :to_i)
      cast_with(Integer, :to_i)
      cast_with(:float, :to_f)
      cast_with(Float, :to_f)
    end
  end
end
