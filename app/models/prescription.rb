# frozen_string_literal: true

class Prescription < ApplicationRecord
  belongs_to :pet
  belongs_to :clinic
  has_many :prescription_details, dependent: :destroy
end
