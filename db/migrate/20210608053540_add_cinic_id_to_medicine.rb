# frozen_string_literal: true

class AddCinicIdToMedicine < ActiveRecord::Migration[6.0]
  def change
    add_reference :medicines, :clinic, foreign_key: true
  end
end
