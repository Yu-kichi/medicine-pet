class AddUserIdToClinics < ActiveRecord::Migration[6.0]
  def change
    add_column :clinics, :user_id, :integer
  end
end
