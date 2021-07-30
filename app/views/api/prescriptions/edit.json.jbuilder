# frozen_string_literal: true

json.prescription do |prescription |
  prescription.date @prescription.date
  prescription.medical_fee @prescription.medical_fee
  prescription.medicine_fee @prescription.medicine_fee
end

json.clinic @prescription.clinic, :id, :name
json.prefecture @prescription.clinic.prefecture, :id, :name
