# frozen_string_literal: true

require "rails_helper"

RSpec.feature Pet, type: :model do
  before do
    @user = create(:user)
    create(:prefecture_1)
    @pet = create(:pet_1, user_id: @user.id)
  end

  scenario "正常なデータがあれば有効" do
    expect(@pet).to be_valid
  end

  scenario "名前がないと失敗" do
    @pet.name = ""
    expect(@pet).not_to be_valid
  end
end
