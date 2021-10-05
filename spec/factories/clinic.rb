# frozen_string_literal: true

FactoryBot.define do
  factory :clinic do
    prefecture_id {1}
    name {"まつい犬猫病院 (北海道)"}
    address{"北海道札幌市東区北26条東10丁目2-1"}
    telephone_number{"011-299-5561"}
  end
end