class CreatePrescriptionsMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions_medicines do |t|
      t.integer :total_amount
      t.integer :dose
      t.text :memo
      t.references :medicine, foreign_key: true
      t.references :prescription, foreign_key: true

      t.timestamps
    end
  end
end
