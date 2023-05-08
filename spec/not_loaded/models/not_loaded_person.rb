# frozen_string_literal: true

class NotLoadedPerson < Baleog::Client::Model
  field :name
  field :age, cast: :integer
end
