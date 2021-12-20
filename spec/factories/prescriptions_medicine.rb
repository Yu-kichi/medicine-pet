# frozen_string_literal: true

FactoryBot.define do
  factory :prescriptions_medicine, class: PrescriptionsMedicine do
    unit { "5mg" }
    dose { 2 }
    total_amount { 20 }
  end
end
