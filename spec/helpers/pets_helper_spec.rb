# frozen_string_literal: true

require "rails_helper"

RSpec.describe PetsHelper, type: :helper do
  scenario "convert_to_age" do
    now = Time.now
    birthday_1 = now.ago(1.day)
    birthday_2 = now.ago(364.day)
    birthday_3 = now.ago(365.day)
    birthday_4 = now.ago(100.year)
    expect(convert_to_age(now)).to eq "(0歳0ヶ月)"
    expect(convert_to_age(birthday_1)).to eq "(0歳0ヶ月)"
    expect(convert_to_age(birthday_2)).to eq "(0歳11ヶ月)"
    expect(convert_to_age(birthday_3)).to eq "(1歳0ヶ月)"
    expect(convert_to_age(birthday_4)).to eq "(100歳0ヶ月)"
  end
end
