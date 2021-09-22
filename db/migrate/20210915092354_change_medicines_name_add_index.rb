class ChangeMedicinesNameAddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :medicines, :name, unique: true
  end
end
