# frozen_string_literal: true

json.array! @pets, partial: "pets/pet", as: :pet
