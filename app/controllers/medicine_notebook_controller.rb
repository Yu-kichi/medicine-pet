# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
    @pet = Pet.find_by(id: params[:pet_id])
    if @pets && @pet.nil?
      @pet = @pets.first
    end
    @clinics = @pet.clinics if @pet
  end
end
