# frozen_string_literal: true

FactoryBot.define do
  factory :prescription_1, class: Prescription do
    date { "20210909" }
    medical_fee { 1500 }
    medicine_fee { 2000 }
    association :clinic,
    factory: :clinic_1
  end

  factory :prescription_2, class: Prescription do
    id { 2 }
    date { "20210909" }
    medical_fee { 1500 }
    medicine_fee { 2000 }
    association :clinic,
    factory: :clinic_2
  end
end
