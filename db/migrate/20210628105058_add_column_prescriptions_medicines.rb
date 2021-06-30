# frozen_string_literal: true

class AddColumnPrescriptionsMedicines < ActiveRecord::Migration[6.0]
  def change
    add_column :prescriptions_medicines, :memo, :text
  end
end
