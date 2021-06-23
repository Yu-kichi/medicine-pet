# frozen_string_literal: true

class RemoveColumnsFromClinics < ActiveRecord::Migration[6.0]
  def change
    remove_column :clinics, :prescription_date, :date
    remove_column :clinics, :doctor_name, :string
    remove_column :clinics, :medical_fee, :integer
    remove_column :clinics, :medicine_fee, :integer
    remove_column :clinics, :memo, :text
    remove_foreign_key :clinics, :pets
    remove_index :clinics, :pet_id
    remove_column :clinics, :pet_id, :bigint
  end
end
