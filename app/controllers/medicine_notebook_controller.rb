# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  def index
    # @pet = Pet.find(params[:pet_id])
    @pet = Pet.find_by(id: params[:pet_id])
    @clinics = @pet.clinics if @pet
    @medicines = @clinics.medicines if @clinics
  end
end
