# frozen_string_literal: true

require "rails_helper"

RSpec.describe PetsHelper, type: :helper do
  scenario "convert_to_age" do
    now = Time.now
    birthday = now.ago(10.month)
    expect(convert_to_age(now)).to eq "(0歳0ヶ月)"
    expect(convert_to_age(birthday)).to eq "(0歳10ヶ月)"
  end
end
