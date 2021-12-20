# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Medicines", type: :request do
  before do
    @user = create(:user)
  end

  it "ログインしている時は200が返る" do
    sign_in @user
    get api_medicines_index_path
    expect(response).to have_http_status(:success)
  end

  it "ログインしていないと401が返る" do
    get api_medicines_index_path
    expect(response).to have_http_status(:unauthorized)
  end
end
