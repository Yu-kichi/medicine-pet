# frozen_string_literal: true

class PrescriptionDetail < ApplicationRecord
  belongs_to :medicine
  belongs_to :prescription
end
