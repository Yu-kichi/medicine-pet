# frozen_string_literal: true

class Medicine < ApplicationRecord
  has_many :prescription_details
  validates :name, uniqueness: true
end
