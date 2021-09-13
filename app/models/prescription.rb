# frozen_string_literal: true

class Prescription < ApplicationRecord
  belongs_to :pet
  belongs_to :clinic
  has_many :prescriptions_medicines, dependent: :destroy
  has_many :medicines, through: :prescriptions_medicines

  def copy_from(source_prescription)
    source_prescription.prescriptions_medicines.each do |prescriptions_medicine|
      new_prescriptions_medicine = prescriptions_medicine.dup
      new_prescriptions_medicine.save
      prescriptions_medicines << new_prescriptions_medicine
    end
    save
  end
end
