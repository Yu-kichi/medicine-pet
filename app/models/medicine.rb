# frozen_string_literal: true

class Medicine < ApplicationRecord
  has_many :prescriptions_medicines
  has_many :prescriptions,  through: :prescriptions_medicines
  validates :name, presence: true, uniqueness: true
end
