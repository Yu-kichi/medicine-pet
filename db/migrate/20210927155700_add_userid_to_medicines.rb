# frozen_string_literal: true

class AddUseridToMedicines < ActiveRecord::Migration[6.0]
  def change
    add_column :medicines, :user_id, :integer
  end
end
