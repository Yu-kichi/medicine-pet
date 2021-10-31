# frozen_string_literal: true

json.pet_name @pet.name

clinic_name = @pet.prescriptions.map do |prescription|
  prescription.clinic.name
end
json.clinic_name clinic_name.uniq

json.prescriptions @pet.prescriptions.each do |prescription|
  json.prescription prescription, :date, :id
  json.clinic_name prescription.clinic.name
  json.medicines prescription.prescriptions_medicines.each do  |medicine|
    json.medicine_name medicine.medicine.name
  end
end
