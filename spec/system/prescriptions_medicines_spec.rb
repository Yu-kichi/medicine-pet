# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Prescriptions_medicines", type: :system do
  before do
    @user = create(:user)
    create(:prefecture_1)
    login_user(@user.email, @user.password)
    @pet = create(:pet_1, user_id: @user.id)
    @medicine = create(:medicine, user_id: @user.id)
    @prescription = create(:prescription_1, pet_id: @pet.id)
  end

  describe "処方箋に薬を登録する" do
    scenario "登録成功" do
      visit "prescriptions/#{@prescription.id}/prescriptions_medicines/new"
      expect(page).to have_content("まつい犬猫病院")
      first(".multiselect__tags").click
      find(".multiselect__input").set("アイボメック" + "\n")
      fill_in "dose", with: "2"
      fill_in "total_amount", with: "21"
      fill_in "medicine_memo", with: "これはテストです"
      click_button "お薬情報を登録する"
      expect(page).to have_content("アイボメック")
      expect(page).to have_content("2錠")
      expect(page).to have_content("21日")
      expect(page).to have_content("これはテストです")
      expect(current_path).to eq "/pets/#{@pet.id}/prescriptions/#{@prescription.id}"
    end

    scenario "追加でお薬登録すると登録が成功し、さらに次の薬登録画面へ移動する" do
      visit "prescriptions/#{@prescription.id}/prescriptions_medicines/new"
      expect(page).to have_content("まつい犬猫病院")
      first(".multiselect__tags").click
      find(".multiselect__input").set("アイボメック" + "\n")
      fill_in "dose", with: "2"
      fill_in "total_amount", with: "21"
      fill_in "medicine_memo", with: "これはテストです"
      click_button "追加でお薬を登録する"
      expect(page).to have_content("アイボメック")
      expect(current_path).to eq "/prescriptions/#{@prescription.id}/prescriptions_medicines/new"
    end

    scenario "登録失敗でバリデーションを表示" do
      visit "prescriptions/#{@prescription.id}/prescriptions_medicines/new"
      click_button "お薬情報を登録する"
      expect(page).to have_content("お薬を選んでください")
    end
  end

  describe "処方箋に登録したお薬の編集削除" do
    before do
      create(:prescriptions_medicine, prescription_id: @prescription.id, medicine_id: @medicine.id)
    end

    scenario "処方箋のお薬編集" do
      visit "/pets/#{@pet.id}/prescriptions/#{@prescription.id}"
      find("#medicine-show-button").click
      click_link "内容修正"
      expect(page).to have_content("お薬情報編集")
      fill_in "medicine_memo", with: "これは編集のテストです"
      click_button "お薬情報を編集する"
      expect(page).to have_content("これは編集のテストです")
    end

    scenario "処方箋のお薬削除" do
      visit "/pets/#{@pet.id}/prescriptions/#{@prescription.id}"
      find("#medicine-show-button").click
      find(".has-text-grey-dark").click
      within(".modal-container") do
        find(".button.is-danger").click
      end
      expect(page).not_to have_content("処方されたお薬")
    end
  end
end
