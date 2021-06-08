# frozen_string_literal: true

class AddPetIdToMedicines < ActiveRecord::Migration[6.0]
  def change
    add_reference :medicines, :pet, foreign_key: true
  end
end
