# frozen_string_literal: true

FactoryBot.define do
  factory :prescriptions_medicine do
    dose {2}
    total_amount{20}
    medicine_id{1}
    #prescription_id{1}
    sequence(:prescription_id) {|n| n}
  end
end