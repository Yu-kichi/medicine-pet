# frozen_string_literal: true

json.pet @pet

clinic_name = @pet.prescriptions.map do |prescription|
  prescription.clinic.name
end
json.clinic_name  clinic_name.uniq

json.prescriptions @pet.prescriptions.each do |prescription|
  json.prescription prescription
  json.clinic_name prescription.clinic.name
  json.clinic_address prescription.clinic.address
  json.clinic_telephone_number prescription.clinic.telephone_number

  json.edit_prescription_path  edit_pet_prescription_path(@pet, prescription)
  json.new_medicine_path new_prescription_prescriptions_medicine_path(prescription)

  json.medicines prescription.prescriptions_medicines.each do  |medicine|
    json.prescriptions_medicines medicine
    json.medicine_name medicine.medicine.name
    json.edit_prescriptions_medicine_path edit_prescription_prescriptions_medicine_path(prescription.id, medicine.id)
  end
end
