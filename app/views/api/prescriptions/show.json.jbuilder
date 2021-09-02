# frozen_string_literal: true

json.prescription @prescription

json.prescription_clinic @prescription.clinic.name
json.clinic_address @prescription.clinic.address
json.clinic_telephone_number @prescription.clinic.telephone_number
json.prescription_date @prescription.date

json.medicines @prescription.prescriptions_medicines.each do  |medicine|
  json.medicine_id medicine.id
  json.medicine_name medicine.medicine.name
  json.total_amount medicine.total_amount
  json.dose medicine.dose
  json.memo medicine.memo
  json.edit_prescriptions_medicine_path edit_prescription_prescriptions_medicine_path(@prescription.id, medicine.id)
end
