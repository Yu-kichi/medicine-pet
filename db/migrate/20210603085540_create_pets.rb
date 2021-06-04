# frozen_string_literal: true

class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.integer :sex
      t.string :breed
      t.float :weight
      t.date :birthday
      t.text :memo
      t.timestamps
    end
  end
end
