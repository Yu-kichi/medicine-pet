# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Prescriptions", type: :system do
  before do
    @user = create(:user)
    create(:prefecture_1)
    create(:prefecture_2)
    login_user(@user.email, @user.password)
  end
  describe "一覧ページ" do
    context "ペット作成前" do
      scenario "サンプル表示" do
        visit "/"
        expect(page).to have_content("初めにペット情報を登録しましょう")
      end
    end

    context "ペット作成後" do
      before do
        @pet = create(:pet_1, user_id: @user.id)
        @medicine = create(:medicine, user_id: @user.id)
        @prescription_1 = create(:prescription_1, pet_id: @pet.id)
        @prescription_2 = create(:prescription_2, pet_id: @pet.id)
        create(:prescriptions_medicine, prescription_id: @prescription_1.id, medicine_id: @medicine.id)
      end

      scenario "処方箋作成リンクが表示される" do
        visit "/"
        expect(page).to have_content("新しくお薬手帳に登録する")
      end

      scenario "処方箋一覧画面で病院名と薬の名前が表示できる" do
        visit "/"
        expect(page).to have_content("まつい犬猫病院 (北海道)")
        expect(page).to have_content("アイボメック")
      end

      scenario "処方箋一覧画面で登録した病院が絞り込みできる" do
        visit "/"
        find(".multiselect__tags").click
        find(".multiselect__input").set("まつい" + "\n")
        expect(page).to have_content("まつい犬猫病院 (北海道)")
        expect(page).not_to have_content("ウェルネス動物病院 (青森県)")
      end

      scenario "処方箋のheader部分をclickすると詳細ページへ移動する" do
        visit "/"
        first(".prescription-header").click
        expect(current_path).to eq "/pets/#{@pet.id}/prescriptions/#{@prescription_2.id}"
        expect(page).to have_content("ウェルネス動物病院")
      end
    end
  end

  describe "処方箋一覧以外" do
    before do
      @pet = create(:pet_1, user_id: @user.id)
      @prescription = create(:prescription_1, pet_id: @pet.id)
      @medicine = create(:medicine, user_id: @user.id)
      create(:prescriptions_medicine, prescription_id: @prescription.id, medicine_id: @medicine.id)
    end

    describe "処方箋作成" do
      scenario "作成成功" do
        visit "/pets/#{@pet.id}/prescriptions/new"
        expect(page).to have_content("処方箋情報登録")
        fill_in "date", with: "002021-10-06"
        first(".multiselect__tags").click
        find(".multiselect__input").set("北海道" + "\n")
        page.all(".multiselect__tags")[1].click
        find(".multiselect__input").set("まつい犬猫病院" + "\n")
        fill_in "medical_fee", with: "2000"
        fill_in "medicine_fee", with: "3000"
        click_button "お薬登録へ進む"
        expect(page).to have_content("2021年10月06日(水)")
        expect(page).to have_content("まつい犬猫病院")
      end

      scenario "処方箋作成失敗バリデーション表示" do
        visit "/pets/#{@pet.id}/prescriptions/new"
        click_button "お薬登録へ進む"
        expect(page).to have_content("診療日を選んでください")
        expect(page).to have_content("病院名を選んでください")
      end

      scenario "処方箋コピー成功" do
        visit "/pets/#{@pet.id}/prescriptions/#{@prescription.id}"
        click_link "コピー"
        expect(page).to have_content("前回の情報を元に薬を一括登録する")
        click_button "一括登録する"
        expect(page).to have_content("まつい犬猫病院", count: 2)
        expect(page).to have_content("アイボメック", count: 2)
      end
    end

    scenario "処方箋編集成功" do
      visit "/pets/#{@pet.id}/prescriptions/#{@prescription.id}"
      first(".column.mt-6").click
      click_link "内容修正"
      expect(page).to have_content("処方箋編集")
      fill_in "date", with: "002021-10-06"
      click_button "編集する"
      expect(page).to have_content("2021年10月06日(水)")
    end

    scenario "処方箋削除成功" do
      visit "/pets/#{@pet.id}/prescriptions/#{@prescription.id}"
      first(".column.mt-6").click
      find(".has-text-grey-dark").click
      within(".modal-container") do
        find(".button.is-danger").click
      end
      expect(page).not_to have_content("まつい犬猫病院")
      expect(current_path).to eq "/pets/#{@pet.id}/medicine_notebook"
    end
  end
end
