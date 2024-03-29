# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Pets", type: :system do
  before do
    @user = create(:user)
    # @other_user = create(:user)
    login_user(@user.email, @user.password)
    @pet = create(:pet_1, user_id: @user.id)
    @other_user_pet = create(:pet_3)
  end

  scenario "ペット一覧表示" do
    create(:pet_2, user_id: @user.id)
    visit "/pets"
    expect(page).to have_content("たろう")
    expect(page).to have_content("ねこみ")
  end

  describe "ペット作成" do
    before do
      visit "/pets/new"
      fill_in "名前", with: "わんきち"
      choose "♂"
      fill_in "ペットの種類", with: "雑種"
      fill_in "体重", with: "7"
      find("#pet_birthday_1i").find("option[value='2000']").select_option
      find("#pet_birthday_2i").find("option[value='1']").select_option
      find("#pet_birthday_3i").find("option[value='1']").select_option
      attach_file "pet_image", "#{Rails.root}/spec/factories/files/pet_profile.png"
      click_button "登録する"
    end

    scenario "ペットを登録するとお薬手帳のページへ遷移する" do
      expect(page).to have_content("ペットを登録しました")
      expect(page).to have_content("わんきちのお薬手帳")
    end

    scenario "ペットの登録した情報が表示できる" do
      visit "/pets/"
      expect(page).to have_content("わんきち")
      expect(page).to have_content("♂")
      expect(page).to have_content("雑種")
      expect(page).to have_content("7.0kg")
      expect(page).to have_content("2000年01月01日生まれ")
      expect(page).to have_selector("img[src$='pet_profile.png']")
    end
  end

  scenario "写真のサイズが大きすぎる場合にエラーを表示する" do
    visit "/pets/new"
    fill_in "名前", with: "わんきち"
    attach_file "pet_image", "#{Rails.root}/spec/factories/files/big_picture.jpg"
    click_button "登録する"
    expect(page).to have_content("画像が大きすぎます、横と縦の長さを2000以下にしてください")
  end

  scenario "写真の形式が異なる場合にエラーを表示する" do
    visit "/pets/new"
    fill_in "名前", with: "わんきち"
    attach_file "pet_image", "#{Rails.root}/spec/factories/files/test.pdf"
    click_button "登録する"
    expect(page).to have_content("画像はPNG, JPG, GIF形式にしてください")
  end

  scenario "ペット編集成功" do
    visit "/pets/#{@pet.id}/edit"
    click_button "更新する"
    expect(page).to have_content("ペットを更新しました")
  end

  scenario "ペット削除成功" do
    visit "/pets/#{@pet.id}"
    click_link "削除する"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content("ペットを削除しました")
    expect(current_path).to eq "/pets"
  end

  describe "他人のペットの場合" do
    around do |example|
      original = Capybara.raise_server_errors
      Capybara.raise_server_errors = false
      example.run
      Capybara.raise_server_errors = original
    end

    scenario "詳細画面を見ることができない" do
      visit "/pets/#{@other_user_pet.id}"
      expect(page).to have_text "ActiveRecord::RecordNotFound"
    end

    scenario "編集画面を見ることができない" do
      visit "/pets/#{@other_user_pet.id}/edit"
      expect(page).to have_text "ActiveRecord::RecordNotFound"
    end
  end
end
