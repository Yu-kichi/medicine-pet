# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Prescriptions", type: :system do
  before do
    @user = create(:user)
    create(:prefecture)
    create(:medicine)
    login_user(@user.email,@user.password)
  end
  context "ペット作成前後の一覧ページ" do 
    scenario "ペット作成前はサンプル表示" do
      visit "/"
      expect(page).to have_content("初めにペット情報を登録しましょう")
    end
    
    scenario "ペット作成後は処方箋作成リンクが表示される" do
      create(:pet_1, user_id: @user.id)
      visit "/"
      expect(page).to have_content("新しくお薬手帳に登録する")
    end
  end

  context "処方箋" do
    before do
      @pet = create(:pet_1, user_id: @user.id)
      create_list(:prescription, 3)
      create_list(:prescriptions_medicine, 3)
    end
    scenario "処方箋一覧画面で病院名と薬の名前が表示できる" do
      visit "/"
      expect(page).to have_content("まつい犬猫病院 (北海道)")
      expect(page).to have_content("アイボメック")
    end

    scenario "処方箋作成成功" do
      visit "/pets/1/prescriptions/new"
      #expect(page).to have_content("kok")
      #fill_in "県名", with: "北海道"
      #fill_in "病院名", with: "雑種"
      #save_and_open_page
      expect(page).to have_content("処方料")
      find(".input.is-small").set(2000)#これだと2つ見つかる
      #find((".input.is-small")[0]).set(2000)#探せない。。
      #find((".control")[3]).set(2000)
      #fill_in "fee", with: "2000"
      #fill_in "処方料", with: "1000"
      click_button "お薬登録へ進む"
    end

    scenario "処方箋作成失敗バリデーション表示" do
      visit "/pets/1/prescriptions/new"
      click_button "お薬登録へ進む"
      expect(page).to have_content("診療日を選んでください")
      expect(page).to have_content("病院名を選んでください")
    end

    scenario "処方箋のheader部分をclickすると詳細ページへ移動する" do
      visit "/"
      first(".prescription-header").click
      expect(current_path).to eq "/pets/1/prescriptions/1"
      expect(page).to have_content("まつい犬猫病院")
    end

    scenario "処方箋編集成功" do
      visit "/pets/1/prescriptions/1/edit"
      click_button "編集する"
    end

    scenario "処方箋削除成功" do
      visit "/pets/1/prescriptions/1"
      first(".column.mt-6").click
      #binding.pry
      find(".has-text-grey-dark").click
      #find_by_id("pre-delete").click
    end
  end
end