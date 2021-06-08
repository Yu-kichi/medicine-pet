# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  def index
    @pet = Pet.find_by(id: params[:pet_id])
    @clinics = @pet.clinics if @pet
  end
end
