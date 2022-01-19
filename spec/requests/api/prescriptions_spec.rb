# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API::Prescriptions", type: :request do
  before do
    @user = create(:user)
    create(:prefecture_1)
    @pet = create(:pet_1, user_id: @user.id)
    @medicine = create(:medicine, user_id: @user.id)
    @prescription_1 = create(:prescription_1, pet_id: @pet.id)
    create(:prescriptions_medicine, prescription_id: @prescription_1.id, medicine_id: @medicine.id)
    @clinic = create(:clinic_1, user_id: @user.id)
  end

  describe "GET /show" do
    scenario "ログインしている時は200が返る" do
      sign_in @user
      get api_prescription_path(id: @prescription_1.id)
      expect(response).to have_http_status(:success)
    end

    scenario "ログインしていないと401が返る" do
      get api_prescription_path(id: @prescription_1.id)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /create" do
    let(:prescription) { { date: "2021-10-10", clinic_id: @clinic.id, pet_id: @pet.id } }
    scenario "登録ができる" do
      sign_in @user
      expect { post api_prescriptions_path, params: { prescription: prescription } }.to change(Prescription, :count).by(1)
    end

    scenario "データが欠けていると登録ができない" do
      sign_in @user
      prescription["clinic_id"] = nil
      expect { post api_prescriptions_path, params: { prescription: prescription } }.not_to change(Prescription, :count)
    end
  end

  describe "PUT /update" do
    scenario "更新ができる" do
      sign_in @user
      put api_prescription_path(id: @prescription_1.id), params: { prescription: { medicine_fee: "11111" } }
      expect(response.status).to eq(200)
      expect(Prescription.first.medicine_fee).to eq(11111)
    end
  end

  describe "DELETE /destroy" do
    scenario "削除できる" do
      sign_in @user
      expect { delete api_prescription_path(id: @prescription_1.id) }.to change(Prescription, :count).by(-1)
      expect(response.status).to eq(200)
    end
  end
end
