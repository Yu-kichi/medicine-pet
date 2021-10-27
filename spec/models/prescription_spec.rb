# frozen_string_literal: true

require "rails_helper"

RSpec.describe Prescription, type: :model do
  scenario "#copy_from" do
    @user = create(:user)
    create(:prefecture_1)
    create(:prefecture_2)
    @pet = create(:pet_1, user_id: @user.id)
    @medicine = create(:medicine, user_id: @user.id)
    @prescription_1 = create(:prescription_1, pet_id: @pet.id)
    @prescription_2 = create(:prescription_2, pet_id: @pet.id)
    @prescriptions_medicine_1 = create(:prescriptions_medicine, medicine_id: @medicine.id, prescription_id: @prescription_1.id)
    @prescriptions_medicine_2 = create(:prescriptions_medicine, medicine_id: @medicine.id, prescription_id: @prescription_2.id)

    expect(@prescription_1.prescriptions_medicines.pluck(:dose, :total_amount, :medicine_id)).to eq @prescription_2.prescriptions_medicines.pluck(:dose, :total_amount, :medicine_id)
  end
end
