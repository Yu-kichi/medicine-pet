# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Clinics", type: :system do
  before do
    @user = create(:user)
    login_user(@user.email, @user.password)
    @pet = create(:pet_1, user_id: @user.id)
    create(:prefecture_1)
    @prescription = create(:prescription_1, pet_id: @pet.id)
  end

  describe "病院情報作成" do
    context "処方箋作成画面から病院情報作成へ移動した時" do
      scenario "作成成功時処方箋作成画面へ戻る" do
        visit "/pets/#{@pet.id}/prescriptions/new"
        click_link "病院名が見つからない時はこちら"
        expect(page).to have_content "病院情報登録"
        find(".multiselect__tags").click
        find(".multiselect__input").set("北海道" + "\n")
        fill_in "病院名 *", with: "いなば動物病院 (北海道)"
        fill_in "住所 *", with: "北海道函館市石川町350-19"
        fill_in "電話番号 *", with: "0138-47-4773"
        click_button "登録する"
        expect(page).to have_content("処方箋情報登録")
        expect(Clinic.count).to eq 2
      end
    end

    context "処方箋編集画面から病院情報作成へ移動した時" do
      scenario "作成成功時処方箋編集画面へ戻る" do
        visit "/pets/#{@pet.id}/prescriptions/#{@prescription.id}/edit"
        click_link "病院名が見つからない時はこちら"
        expect(page).to have_content "病院情報登録"
        find(".multiselect__tags").click
        find(".multiselect__input").set("北海道" + "\n")
        fill_in "病院名 *", with: "いなば動物病院 (北海道)"
        fill_in "住所 *", with: "北海道函館市石川町350-19"
        fill_in "電話番号 *", with: "0138-47-4773"
        click_button "登録する"
        expect(page).to have_content("処方箋編集")
        expect(Clinic.count).to eq 2
      end
    end

    context "病院登録失敗" do
      scenario "バリデーション表示" do
        visit "/pets/#{@pet.id}/prescriptions/new"
        click_link "病院名が見つからない時はこちら"
        expect(page).to have_content "病院情報登録"
        click_button "登録する"
        expect(page).to have_content("県名を選んでください")
        expect(page).to have_content("病院名を入力してください")
        expect(page).to have_content("住所を入力してください")
        expect(page).to have_content("電話番号を入力してください")
      end
    end

  end
end
