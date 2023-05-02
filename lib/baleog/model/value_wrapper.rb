# frozen_string_literal: true

class Baleog
  class Model
    class ValueWrapper < Sinclair::Caster
      master_caster!

      cast_with(:string, :to_s)
      cast_with(String, :to_s)
      cast_with(:integer, :to_i)
      cast_with(Integer, :to_i)
      cast_with(:float, :to_f)
      cast_with(Float, :to_f)
    end
  end
end
