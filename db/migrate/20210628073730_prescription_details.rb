class PrescriptionDetails < ActiveRecord::Migration[6.0]
  def change
    drop_table :prescription_details
  end
end
