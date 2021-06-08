# frozen_string_literal: true

class RemoveKeyToMedicines < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :medicines, :clinics
  end
end
