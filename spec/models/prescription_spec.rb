# frozen_string_literal: true

require "rails_helper"

RSpec.describe Prescription, type: :model do
  before do
    @user = create(:user)
    create(:prefecture_1)
    @pet = create(:pet_1, user_id: @user.id)
  end

  scenario "正常なデータがあれば有効" do
    @prescription = create(:prescription_1, pet_id: @pet.id)
    expect(@prescription).to be_valid
  end

  scenario "日付がないと無効" do
    @prescription = create(:prescription_1, pet_id: @pet.id)
    @prescription.date = ""
    expect(@prescription).not_to be_valid
  end

  scenario "ペットのidがないと無効" do
    @prescription = create(:prescription_1, pet_id: @pet.id)
    @prescription.pet_id = ""
    expect(@prescription).not_to be_valid
  end

  scenario "病院がないと無効" do
    @prescription = create(:prescription_1, pet_id: @pet.id)
    @prescription.clinic_id = ""
    expect(@prescription).not_to be_valid
  end

  scenario "#copy_from" do
    create(:prefecture_2)
    @medicine = create(:medicine, user_id: @user.id)
    @prescription_1 = create(:prescription_1, pet_id: @pet.id)
    @prescription_2 = create(:prescription_2, pet_id: @pet.id)
    @prescriptions_medicine_1 = create(:prescriptions_medicine, medicine_id: @medicine.id, prescription_id: @prescription_1.id)
    @prescriptions_medicine_2 = create(:prescriptions_medicine, medicine_id: @medicine.id, prescription_id: @prescription_2.id)

    expect(@prescription_1.prescriptions_medicines.pluck(:dose, :total_amount, :medicine_id)).to eq @prescription_2.prescriptions_medicines.pluck(:dose, :total_amount, :medicine_id)
  end
end
