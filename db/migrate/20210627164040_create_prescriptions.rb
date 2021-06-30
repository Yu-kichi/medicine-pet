# frozen_string_literal: true

class CreatePrescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions do |t|
      t.date :date,        null: false
      t.integer :medical_fee
      t.integer :medicine_fee
      t.references :pet, foreign_key: true
      t.references :clinic, foreign_key: true

      t.timestamps
    end
  end
end
