# frozen_string_literal: true

json.prescriptions_medicine do |prescriptions_medicine|
  prescriptions_medicine.dose @prescriptions_medicine.dose
  prescriptions_medicine.total_amount @prescriptions_medicine.total_amount
  prescriptions_medicine.memo @prescriptions_medicine.memo
end

json.medicine @prescriptions_medicine.medicine, :id, :name
