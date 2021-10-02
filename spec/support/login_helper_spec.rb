# frozen_string_literal: true

require "rails_helper"

module LoginHelpers
  def login_user(email, password)
    visit "/users/sign_in"
    fill_in("メールアドレス", with: email)
    fill_in("パスワード", with: password)
    click_button "ログイン"
  end

  def logout
    visit "/users/logout"
  end
end
