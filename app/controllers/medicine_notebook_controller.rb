# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  before_action :authenticate_user!
  def index
    @pets = Pet.all
    @pet = Pet.find_by(id: params[:pet_id])
    @clinics = @pet.clinics if @pet
  end
end
