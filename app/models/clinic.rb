# frozen_string_literal: true

class Clinic < ApplicationRecord
  has_many :prescriptions
  validates :name, uniqueness: true
end
