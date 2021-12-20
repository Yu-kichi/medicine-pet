# frozen_string_literal: true

require "rails_helper"

RSpec.describe PrescriptionsMedicine, type: :model do
  before do
    @user = create(:user)
    create(:prefecture_1)
    @pet = create(:pet_1, user_id: @user.id)
    @medicine = create(:medicine, user_id: @user.id)
    @prescription = create(:prescription_1, pet_id: @pet.id)
  end

  scenario "正常なデータがあれば登録有効" do
    @prescriptions_medicine = create(:prescriptions_medicine, prescription_id: @prescription.id, medicine_id: @medicine.id)
    expect(@prescriptions_medicine).to be_valid
  end

  scenario "薬がないと無効" do
    @prescriptions_medicine = build(:prescriptions_medicine, prescription_id: @prescription.id)
    expect(@prescriptions_medicine).not_to be_valid
  end

  scenario "処方箋がないと無効" do
    @prescriptions_medicine = build(:prescriptions_medicine, medicine_id: @medicine.id)
    expect(@prescriptions_medicine).not_to be_valid
  end
end
