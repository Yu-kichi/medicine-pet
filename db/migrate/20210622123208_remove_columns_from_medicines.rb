class RemoveColumnsFromMedicines < ActiveRecord::Migration[6.0]
  def change
    remove_column :medicines, :quantity, :string 
    remove_column :medicines, :memo, :text
    
    remove_index :medicines, :clinic_id
    remove_column :medicines,:clinic_id,:bigint 

    remove_foreign_key :medicines, :pets
    remove_index :medicines, :pet_id
    remove_column :medicines,:pet_id,:bigint 
  end
end
