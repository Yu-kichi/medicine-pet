# frozen_string_literal: true

FactoryBot.define do
  factory :prescription_1, class: Prescription do
    date { "20210101" }
    medical_fee { 1500 }
    medicine_fee { 2000 }
    association :clinic,
    factory: :clinic_1
  end

  factory :prescription_2, class: Prescription do
    date { "20210102" }
    medical_fee { 1000 }
    medicine_fee { 1000 }
    association :clinic,
    factory: :clinic_2
  end

  factory :prescription_3, class: Prescription do
    date { "20210103" }
    medical_fee { 1500 }
    medicine_fee { 2000 }
    association :clinic,
    factory: :clinic_3
    association :pet,
    factory: :pet_3
  end
end
