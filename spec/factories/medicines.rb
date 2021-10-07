# frozen_string_literal: true

FactoryBot.define do
  factory :medicine do
    name { "アイボメック" }
    association :user,
    factory: :user
  end
end
