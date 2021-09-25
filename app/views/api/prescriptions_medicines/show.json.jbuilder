# frozen_string_literal: true

json.prescription_clinic @prescription.clinic.name
json.prescription_date @prescription.date

json.medicines @prescription.prescriptions_medicines.each do |medicine|
  json.medicine_name medicine.medicine.name
  json.total_amount medicine.total_amount
  json.dose medicine.dose
  json.memo medicine.memo
end
