# frozen_string_literal: true

class AddPetIdToClinics < ActiveRecord::Migration[6.0]
  def change
    add_reference :clinics, :pet, foreign_key: true
  end
end
