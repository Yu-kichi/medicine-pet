# frozen_string_literal: true

class CreatePrescriptionDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :prescription_details do |t|
      t.references :prescription, foreign_key: true
      t.references :medicine, foreign_key: true

      t.timestamps
    end
  end
end
