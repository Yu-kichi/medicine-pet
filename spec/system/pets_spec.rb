# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Pets", type: :system do
  before do
    create(:pet_1, name: "たろう")
  end

  context "ペット" do
    before do
      visit "/users/sign_in"
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    scenario "ペット一覧表示" do
      create(:pet_2, name: "ねこみ")
      visit "/pets"
      expect(page).to have_content("たろう")
      expect(page).to have_content("ねこみ")
    end

    scenario "ペット作成成功" do
      visit "/pets/new"
      fill_in "名前", with: "わんきち"
      choose "オス"
      fill_in "品種", with: "雑種"
      fill_in "体重", with: "7"
      find("#pet_birthday_1i").find("option[value='2000']").select_option
      find("#pet_birthday_2i").find("option[value='1']").select_option
      find("#pet_birthday_3i").find("option[value='1']").select_option
      attach_file "pet_image", "#{Rails.root}/spec/factories/pet_profile.png"
      click_button "登録する"
      expect(page).to have_content("ペットを作成しました")
      expect(page).to have_content("わんきち")
      expect(page).to have_content("オス")
      expect(page).to have_content("雑種")
      expect(page).to have_content("体重:7.0kg")
      expect(page).to have_content("誕生日:2000年01月01日")
      expect(page).to have_selector("img[src$='pet_profile.png']")
    end

    scenario "ペット編集成功" do
      visit "/pets/1/edit"
      click_button "更新する"
      expect(page).to have_content("ペットを更新しました")
    end

    scenario "ペット削除成功" do
      visit "/pets/1"
      click_link "削除する"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("ペットを削除しました")
      expect(current_path).to eq "/pets"
    end
  end
end