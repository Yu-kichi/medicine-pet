# frozen_string_literal: true

class AddColumnsToClinics < ActiveRecord::Migration[6.0]
  def change
    add_column :clinics, :address, :string, null: false
    add_column :clinics, :telephone_number, :string, null: false
  end
end
