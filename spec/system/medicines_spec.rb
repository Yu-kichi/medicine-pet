# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Medicines", type: :system do
  before do
    @user = create(:user)
    create(:prefecture_1)
    create(:medicine)
    login_user(@user.email, @user.password)
    @pet = create(:pet_1, user_id: @user.id)
    @prescription = create(:prescription_1, pet_id: @pet.id)
  end

  context "薬品" do
    scenario "作成した薬だけが一覧で見れる" do
      @user_2 = create(:user, id: 2, email: "test2@example.com", password: "password")
      create(:medicine, id: 2, user_id: @user_2.id, name: "薬テスト２")
      visit "medicines"
      expect(page).to have_content("アイボメック")
      expect(page).not_to have_content("薬テスト２")
    end

    scenario "処方箋薬作成ページから薬品名新規登録" do
      visit "/prescriptions/1/prescriptions_medicines/new"
      click_link "薬の名前が見つからない時はこちら"
      expect(page).to have_content("お薬名登録")
      fill_in "薬の名前", with: "薬テスト１"
      click_button "登録する"
      expect(current_path).to eq "/prescriptions/1/prescriptions_medicines/new"
      expect(page).to have_content("新しく薬の名前を登録しました")
    end

    scenario "処方箋薬編集ページから薬品名新規登録" do
      create(:prescriptions_medicine_1, prescription_id: @prescription.id)
      visit "/prescriptions/1/prescriptions_medicines/1/edit"
      click_link "薬の名前が見つからない時はこちら"
      expect(page).to have_content("お薬名登録")
      fill_in "薬の名前", with: "薬テスト１"
      click_button "登録する"
      expect(current_path).to eq "/prescriptions/1/prescriptions_medicines/1/edit"
      expect(page).to have_content("新しく薬の名前を登録しました")
    end

    scenario "お薬情報編集" do
      visit "/medicines/1/edit"
      fill_in "薬の名前", with: "薬テスト１"
      click_button "編集する"
      expect(page).to have_content("薬の名前を更新しました")
    end

    scenario "お薬情報削除" do
      visit "/medicines"
      find(".fa-trash").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("薬の名前を削除しました")
      expect(page).not_to have_content("アイボメック")
    end
  end
end
