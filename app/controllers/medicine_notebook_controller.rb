# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  def index
    if current_user
      redirect_to new_pet_path if current_user.pets.empty?
      @pets = current_user.pets
      if params[:pet_id]
        @pet = Pet.find_by(id: params[:pet_id])
      elsif @pets.present?
        @pet = current_user.pets.with_attached_image.first
      end
    else
      render template: "welcome/index"
    end
  end
end
