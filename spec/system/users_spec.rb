# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Users", type: :system do
  describe "サインアップ" do
    scenario "成功" do
      visit "/users/sign_up"
      expect(current_path).to eq "/users/sign_up"
      fill_in "メールアドレス", with: "alice@example.com"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      click_button "サインアップ"
      expect(page).to have_content("アカウント登録が完了しました。")
    end
  end

  describe "ログイン" do
    before do
      create(:user, email: "tester1@example.com")
      visit "/users/sign_in"
    end
    scenario "成功" do
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      expect(page).to have_content("ログインしました。")
    end
    scenario "間違ったパスワードを入力するとログイン失敗" do
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "test"
      click_button "ログイン"
      expect(page).to have_content("メールアドレスまたはパスワードが違います。")
    end
  end

  describe "ユーザー情報編集" do
    before do
      @user = create(:user)
      login_user(@user.email, @user.password)
      visit "users/edit"
    end
    scenario "メールアドレス変更成功" do
      fill_in "メールアドレス", with: "change@example.com"
      fill_in "現在のパスワード", with: "password"
      click_button "変更する"
      expect(page).to have_content("アカウント情報を変更しました。")
    end

    scenario "パスワード変更成功" do
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "ChangePass"
      fill_in "確認用パスワード", with: "ChangePass"
      fill_in "現在のパスワード", with: "password"
      click_button "変更する"
      expect(page).to have_content("アカウント情報を変更しました。")
    end

    scenario "アカウント削除成功" do
      page.accept_confirm do
        click_on "アカウント削除"
      end
      expect(page).to have_content("アカウントを削除しました。またのご利用をお待ちしております。")

      visit "/users/sign_in"
      fill_in "メールアドレス", with: "tester1@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      assert_text "メールアドレスまたはパスワードが違います。"
    end
  end
end
