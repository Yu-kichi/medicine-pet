# frozen_string_literal: true

json.clinics @prescription.clinic, :name, :address, :telephone_number
json.prescriptions @prescription, :date, :medicine_fee, :medical_fee

json.medicines @prescription.prescriptions_medicines.each do |medicine|
  json.medicine_id medicine.id
  json.medicine_name medicine.medicine.name
  json.total_amount medicine.total_amount
  json.dose medicine.dose
  json.memo medicine.memo
  json.unit medicine.unit
  json.edit_prescriptions_medicine_path edit_prescription_prescriptions_medicine_path(@prescription.id, medicine.id)
end
