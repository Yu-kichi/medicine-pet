# frozen_string_literal: true

FactoryBot.define do
  factory :clinic_1, class: Clinic do
    prefecture_id { 1 }
    name { "まつい犬猫病院 (北海道)" }
    address { "北海道札幌市東区北26条東10丁目2-1" }
    telephone_number { "011-299-5561" }
  end

  factory :clinic_2, class: Clinic do
    prefecture_id { 2 }
    name { "ウェルネス動物病院 (青森県)" }
    address { "青森県青森市奥野4-15-7" }
    telephone_number { "017-757-9273" }
  end
end
