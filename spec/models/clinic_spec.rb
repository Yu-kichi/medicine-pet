# frozen_string_literal: true

require "rails_helper"

RSpec.feature Clinic, type: :model do
  before do
    @user = create(:user)
    create(:prefecture_1)
    @clinic = create(:clinic_1, user_id: @user.id)
  end

  scenario "正常なデータがあれば有効" do
    expect(@clinic).to be_valid
  end

  scenario "病院名がないと無効" do
    @clinic.name = ""
    expect(@clinic).not_to be_valid
  end

  scenario "住所がなければ無効" do
    @clinic.address = ""
    expect(@clinic).not_to be_valid
  end

  scenario "電話番号がなければ無効" do
    @clinic.telephone_number = ""
    expect(@clinic).not_to be_valid
  end

  scenario "県名がなければ無効" do
    @clinic.prefecture_id = ""
    expect(@clinic).not_to be_valid
  end
end
