# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API::Pets", type: :request do
  before do
    @user = create(:user)
    @pet = create(:pet_1, user_id: @user.id)
  end

  it "ログインしている時は200が返る" do
    sign_in @user
    get api_pets_index_path(pet_id: @pet.id)
    expect(response).to have_http_status(:success)
  end

  it "ログインしていないと401が返る" do
    get api_pets_index_path
    expect(response).to have_http_status(:unauthorized)
  end
end
