# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = User.create({
      email: "test@exapmle.com",
      password: "password",
      })
  end

  scenario "メール、パスワードがある場合、有効" do
    expect(@user).to be_valid
  end

  scenario "パスワードがない場合、無効" do
    @user.password = ""
    expect(@user).not_to be_valid
  end

  scenario "パスワードが6文字以下の場合、無効" do
    @user.password = "a" * 5
    expect(@user).not_to be_valid
  end

  scenario "パスワードが129文字以上の場合、無効" do
    @user.password = "a" * 129
    expect(@user).not_to be_valid
  end

  scenario "メールがない場合、無効" do
    @user.email = ""
    expect(@user).not_to be_valid
  end

  scenario "メールに@がない場合、無効" do
    @user.email = "testexample.com"
    expect(@user).not_to be_valid
  end

  scenario "既に同じメールがある場合、無効" do
    @user2 = User.new({
      email: "test@exapmle.com",
      password: "password2",
      })
    expect(@user2).not_to be_valid
  end
end
