# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API::Prescriptions_medicines", type: :request do
  before do
    @user = create(:user)
    create(:prefecture_1)
    @pet = create(:pet_1, user_id: @user.id)
    @medicine = create(:medicine, user_id: @user.id)
    @prescription = create(:prescription_1, pet_id: @pet.id)
    @prescription_medicine = create(:prescriptions_medicine, prescription_id: @prescription.id, medicine_id: @medicine.id)
  end

  describe "GET /show" do
    scenario "ログインしている時は200が返る" do
      sign_in @user
      get api_prescriptions_medicine_path(id: @prescription.id)
      expect(response).to have_http_status(:success)
    end

    scenario "ログインしていないと401が返る" do
      get api_prescriptions_medicine_path(id: @prescription.id)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /create" do
    let(:prescriptions_medicine) { { prescription_id: @prescription.id, medicine_id: @medicine.id } }
    scenario "登録ができる" do
      sign_in @user
      expect { post api_prescriptions_medicines_path, params: { prescriptions_medicine: prescriptions_medicine } }.to change(PrescriptionsMedicine, :count).by(1)
    end

    scenario "データが欠けていると登録ができない" do
      sign_in @user
      prescriptions_medicine["medicine_id"] = nil
      expect { post api_prescriptions_medicines_path, params: { prescriptions_medicine: prescriptions_medicine } }.not_to change(PrescriptionsMedicine, :count)
    end
  end

  describe "PUT /update" do
    scenario "更新ができる" do
      sign_in @user
      put api_prescriptions_medicine_path(id: @prescription_medicine.id), params: { prescriptions_medicine: { unit: "1mg" } }
      expect(response.status).to eq(200)
      expect(PrescriptionsMedicine.first.unit).to eq("1mg")
    end
  end

  describe "DELETE /destroy" do
    scenario "削除できる" do
      sign_in @user
      expect { delete api_prescriptions_medicine_path(id: @prescription_medicine.id) }.to change(PrescriptionsMedicine, :count).by(-1)
      expect(response.status).to eq(200)
    end
  end
end
