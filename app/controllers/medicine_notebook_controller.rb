# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
    if params[:pet_id]
      @pet = Pet.find_by(id: params[:pet_id])
    elsif @pets.present?
      @pet = current_user.pets.first
    end
  end
end
