json.pet @pet
# json.prescriptions @pet.prescriptions

json.prescriptions @pet.prescriptions.each do |prescription|
  json.prescription prescription
  json.clinic_name prescription.clinic.name
  json.clinic_address prescription.clinic.address
  json.clinic_telephone_number prescription.clinic.telephone_number
  
  json.edit_prescription_path  edit_pet_prescription_path(@pet,prescription)
  json.new_medicine_path  new_prescription_prescriptions_medicine_path(prescription) 
  
  #json.prescription.prescriptions_medicines prescription.prescriptions_medicines

  json.medicines prescription.prescriptions_medicines.each do  |medicine|
    json.prescriptions_medicines medicine
    json.medicine_name medicine.medicine.name
    json.edit_prescriptions_medicine_path edit_prescription_prescriptions_medicine_path(prescription.id,medicine.id)
  end
end



