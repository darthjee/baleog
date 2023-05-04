# frozen_string_literal: true

class Person < Baleog::Model
  field :name
  field :age, cast: :integer
end
