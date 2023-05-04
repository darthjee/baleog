# frozen_string_literal: true

class NotLoadedPerson < Baleog::Model
  field :name
  field :age, cast: :integer
end
