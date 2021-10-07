# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Users", type: :system do
  scenario "サインアップ成功" do
    visit "/users/sign_up"
    expect(current_path).to eq "/users/sign_up"
    fill_in "メールアドレス", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"
    click_button "サインアップ"
    expect(page).to have_content("アカウント登録が完了しました。")
  end

  scenario "ログイン成功" do
    create(:user, email: "tester1@example.com")
    visit "/users/sign_in"
    expect(current_path).to eq "/users/sign_in"
    fill_in "メールアドレス", with: "tester1@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_content("ログインしました。")
  end
end
