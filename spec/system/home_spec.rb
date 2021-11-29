# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Home", type: :system do
  before do
    @user = create(:user)
    @pet = create(:pet_1, user_id: @user.id)
  end

  describe "Homeページ" do
    context "ログイン前" do
      scenario "ログイン前はwelcomeページが表示される" do
        visit "/"
        expect(page).to have_content("アカウント作成")
      end
    end

    context "ログイン後" do
      scenario "ログイン後はお薬手帳ページが表示される" do
        login_user(@user.email, @user.password)
        visit "/"
        expect(page).to have_content("たろうのお薬手帳")
      end
    end
  end

  describe "ヘッダー" do
    context "ペットに写真が登録されている" do
      scenario "ヘッダーに写真が表示される" do
        @pet_2 = create(:pet_2, user_id: @user.id)
        login_user(@user.email, @user.password)
        visit "/pets/#{@pet_2.id}/medicine_notebook"
        expect(page).to have_css(".pet_image_icon")
      end
    end

    context "ペットに写真が登録されていない" do
      scenario "ヘッダーに写真が表示されない" do
        login_user(@user.email, @user.password)
        visit "/"
        expect(page).to have_content("たろうのお薬手帳")
        expect(page).not_to have_css(".pet_image_icon")
      end
    end

    context "ペットが複数登録されている" do
      scenario "ヘッダーでペット選択ができる" do
        @pet_2 = create(:pet_2, user_id: @user.id)
        login_user(@user.email, @user.password)
        visit "/"
        expect(page).to have_content("たろうのお薬手帳")
        find("#select-pet").click
        all("li.pb-2")[1].click
        expect(page).to have_content("ねこみのお薬手帳")
      end
    end

    context "ペットが複数登録されていない" do
      scenario "ペット選択表示がない" do
        login_user(@user.email, @user.password)
        visit "/"
        expect(page).not_to have_css "#select-pet"
      end
    end

    context "ログイン時" do
      scenario "各種リンクが表示される" do
        login_user(@user.email, @user.password)
        visit "/"
        find("#menu-button").click
        expect(page).to have_content("ペット一覧")
        expect(page).to have_content("ユーザー情報編集")
        expect(page).to have_content("薬品リストに追加したお薬")
        expect(page).to have_content("病院リストに追加した病院")
        expect(page).to have_content("ログアウト")
      end
    end

    context "非ログイン時" do
      scenario "ログインしていない時はログインとサインアップが表示される" do
        visit "/"
        find("#menu-button").click
        expect(page).to have_content("ログイン")
        expect(page).to have_content("アカウント作成")
      end
    end
  end
end
