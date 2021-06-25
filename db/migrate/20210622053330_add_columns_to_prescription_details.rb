# frozen_string_literal: true

class AddColumnsToPrescriptionDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :prescription_details, :quantity, :integer
    add_column :prescription_details, :for_days, :integer
    add_column :prescription_details, :memo, :text
  end
end
