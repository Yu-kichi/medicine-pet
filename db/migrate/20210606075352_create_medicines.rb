class CreateMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :medicines do |t|
      t.string :name, null: false
      t.string :quantity, null:false
      t.text :memo
      t.timestamps
    end
  end
end
