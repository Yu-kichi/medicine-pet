# frozen_string_literal: true

FactoryBot.define do
  factory :medicine do
    id { 1 }
    name { "アイボメック" }
    user_id { 1 }
  end
end
