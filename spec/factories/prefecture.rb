# frozen_string_literal: true

FactoryBot.define do
  factory :prefecture_1, class: Prefecture do
    id { 1 }
    name { "北海道" }
  end

  factory :prefecture_2, class: Prefecture do
    id { 2 }
    name { "青森" }
  end

  factory :prefecture_3, class: Prefecture do
    id { 3 }
    name { "岩手" }
  end
end
