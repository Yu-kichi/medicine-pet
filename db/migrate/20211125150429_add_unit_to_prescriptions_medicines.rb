# frozen_string_literal: true

class AddUnitToPrescriptionsMedicines < ActiveRecord::Migration[6.0]
  def change
    add_column :prescriptions_medicines, :unit, :string
  end
end
