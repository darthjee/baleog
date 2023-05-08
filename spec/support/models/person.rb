# frozen_string_literal: true

class Person < Baleog::Client::Model
  field :id
  field :name
  field :age, cast: :integer
end
