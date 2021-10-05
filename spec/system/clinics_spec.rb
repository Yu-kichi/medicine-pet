# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Clinics", type: :system do
  before do
    @user = create(:user)
    create(:pet_1, user_id: @user.id)
  end

  context "病院" do
    before do
      create(:prefecture)
      login_user(@user.email, @user.password)
    end

    scenario "病院情報登録成功" do
      visit "/pets/1/prescriptions/new"
      click_link "病院名が見つからない時はこちら"
      sleep 2 
      expect(page).to have_content '病院情報登録'
      expect(current_path).to eq "/clinics/new/"
      #fill_in "県名", with:"北海道"
      #fill_in "病院名", with:"いなば動物病院 (北海道)"
      #fill_in "住所 *",with:"北海道函館市石川町350-19"
      #fill_in "clinic_address",with:"北海道函館市石川町350-19"
      #find(".input.full-width").set("入力値")
      #fill_in "電話番号 *",with:"0138-47-4773"
      click_button "登録する"
    end
  end
end