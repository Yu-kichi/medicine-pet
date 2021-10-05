# frozen_string_literal: true

FactoryBot.define do
  factory :prescription do
    sequence(:id) {|n| n}
    date {"20210909"}
    medical_fee {1500}
    medicine_fee {2000}
    pet_id {1}
    #sequence(clinic_id){|n| n}
    #clinic_id {1}
    association :clinic,
    factory: :clinic
  end
end