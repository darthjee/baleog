# frozen_string_literal: true

class Person < Baleog::Client::Model
  field :name
  field :age, cast: :integer
end
