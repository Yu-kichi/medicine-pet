# frozen_string_literal: true

require "rails_helper"

RSpec.feature Medicine, type: :model do
  before do
    @user = create(:user)
    @medicine = create(:medicine, user_id: @user.id)
  end

  scenario "正常なデータがあれば有効" do
    expect(@medicine).to be_valid
  end

  scenario "名前がないと無効" do
    @medicine.name = ""
    expect(@medicine).not_to be_valid
  end

  scenario "名前が重複すると無効" do
    @medicine_2 = build(:medicine, user_id: @user.id, name: "アイボメック")
    expect(@medicine_2).not_to be_valid
  end
end
