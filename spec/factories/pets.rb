# frozen_string_literal: true

FactoryBot.define do
  factory :pet_1, class: Pet do
    name { "たろう" }
    sex { "1" }
    breed { "秋田犬" }
    weight { "8" }
    birthday { "20201010" }
  end

  factory :pet_2, class: Pet do
    name { "ねこみ" }
    sex { "2" }
    breed { "シャム猫" }
    weight { "7" }
    birthday { "20210101" }
    after(:build) do |post|
      post.image.attach(io: File.open("#{Rails.root}/spec/factories/files/pet_profile.png"), filename: "test_image.png", content_type: "image/png")
    end
  end
end
