# frozen_string_literal: true

FactoryBot.define do
  factory :pet_1, class: Pet do
    id { 1 }
    name { "たろう" }
    sex { "1" }
    breed { "秋田犬" }
    weight { "8" }
    birthday { "20201010" }
  end

  factory :pet_2, class: Pet do
    id { 2 }
    name { "ねこみ" }
    sex { "2" }
    breed { "シャム猫" }
    weight { "7" }
    birthday { "20210101" }
  end
end
