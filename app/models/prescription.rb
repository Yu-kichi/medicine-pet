# frozen_string_literal: true

class Prescription < ApplicationRecord
  belongs_to :pet
  belongs_to :clinic
  has_many :prescriptions_medicines, dependent: :destroy
end
