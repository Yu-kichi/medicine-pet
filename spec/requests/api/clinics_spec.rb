# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Clinics", type: :request do
  before do
    @user = create(:user)
    @pet = create(:pet_1, user_id: @user.id)
    @prefecture = create(:prefecture_1)
    @prescription = create(:prescription_1, pet_id: @pet.id)
    @clinic = create(:clinic_1, user_id: @user.id)
  end

  describe "GET /show" do
    scenario "ログインしている時は200が返る" do
      sign_in @user
      get api_clinic_path(id: @clinic.id)
      expect(response).to have_http_status(:success)
    end

    scenario "ログインしていないと401が返る" do
      get api_clinic_path(id: @clinic.id)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /create" do
    let(:clinic) { { name: "犬猫病院", prefecture_id: @prefecture.id, address: "東京都", telephone_number: "012-345-6789", user_id: @user.id } }
    scenario "登録ができる" do
      sign_in @user
      expect { post api_clinics_path, params: { clinic: clinic } }.to change(Clinic, :count).by(1)
    end

    scenario "データが欠けていると登録ができない" do
      sign_in @user
      clinic["name"] = nil
      expect { post api_clinics_path, params: { clinic: clinic } }.not_to change(Clinic, :count)
    end
  end

  describe "PUT /update" do
    scenario "更新ができる" do
      sign_in @user
      put api_clinic_path(id: @clinic.id), params: { clinic: { name: "東京犬猫病院(テスト)" } }
      expect(response.status).to eq(200)
      expect(Clinic.second.name).to eq("東京犬猫病院(テスト)")
    end
  end
end
