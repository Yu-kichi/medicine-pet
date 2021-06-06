# frozen_string_literal: true

class CreateClinics < ActiveRecord::Migration[6.0]
  def change
    create_table :clinics do |t|
      t.string :name, null: false
      t.date :prescription_date, null: false
      t.string :doctor_name
      t.integer :medical_fee
      t.integer :medicine_fee
      t.text :memo
      t.timestamps
    end
  end
end
