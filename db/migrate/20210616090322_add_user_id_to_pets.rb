# frozen_string_literal: true

class AddUserIdToPets < ActiveRecord::Migration[6.0]
  def change
    add_reference :pets, :user, foreign_key: true
  end
end
