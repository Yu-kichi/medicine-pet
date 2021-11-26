# frozen_string_literal: true

json.prescription_clinic @prescription.clinic.name
json.prescription_date @prescription.date

json.medicines @prescription.prescriptions_medicines.each do |medicine|
  json.medicine_name medicine.medicine.name
end
