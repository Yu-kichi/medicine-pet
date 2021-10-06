# frozen_string_literal: true

FactoryBot.define do
  factory :prescription_1, class: Prescription do
    id { 1 }
    date { "20210909" }
    medical_fee { 1500 }
    medicine_fee { 2000 }
    # pet_id {1}
    # sequence(clinic_id){|n| n}
    # clinic_id {1}
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
  # factory :prescription do
  #   id {3}
  #   #sequence(:id) {|n| n}
  #   date {"20210909"}
  #   medical_fee {1500}
  #   medicine_fee {2000}
  #   pet_id {1}
  #   #sequence(clinic_id){|n| n}
  #   #clinic_id {1}
  #   association :clinic,
  #   factory: :clinic
  # end
end
