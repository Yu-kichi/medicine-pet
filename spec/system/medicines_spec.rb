# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Medicines", type: :system do
  before do
    @user = create(:user)
    login_user(@user.email, @user.password)
    create(:prefecture_1)
    @medicine = create(:medicine, user_id: @user.id)
    @pet = create(:pet_1, user_id: @user.id)
    @prescription = create(:prescription_1, pet_id: @pet.id)
  end

  scenario "作成した薬だけが一覧で見れる" do
    @user_2 = create(:user)
    create(:medicine, user_id: @user_2.id, name: "薬テスト２")
    visit "medicines"
    expect(page).to have_content("アイボメック")
    expect(page).not_to have_content("薬テスト２")
  end

  describe "お薬情報作成" do
    context "処方箋薬作成ページから薬品名新規登録" do
      scenario "作成成功時処方箋作成画面へ戻る" do
        visit "/prescriptions/#{@prescription.id}/prescriptions_medicines/new"
        click_link "薬の名前が見つからない時はこちら"
        expect(page).to have_content("お薬名登録")
        fill_in "薬の名前", with: "薬テスト１"
        click_button "登録する"
        expect(current_path).to eq "/prescriptions/#{@prescription.id}/prescriptions_medicines/new"
        expect(page).to have_content("新しく薬の名前を登録しました")
      end
    end

    context "処方箋薬編集ページから薬品名新規登録" do
      scenario "作成成功時処方箋編集画面へ戻る" do
        prescriptions_medicine = create(:prescriptions_medicine, prescription_id: @prescription.id, medicine_id: @medicine.id)
        visit "/prescriptions/#{@prescription.id}/prescriptions_medicines/#{prescriptions_medicine.id}/edit"
        click_link "薬の名前が見つからない時はこちら"
        expect(page).to have_content("お薬名登録")
        fill_in "薬の名前", with: "薬テスト１"
        click_button "登録する"
        expect(current_path).to eq "/prescriptions/#{@prescription.id}/prescriptions_medicines/#{prescriptions_medicine.id}/edit"
        expect(page).to have_content("新しく薬の名前を登録しました")
      end
    end
  end

  scenario "お薬情報編集" do
    visit "/medicines/#{@medicine.id}/edit"
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
