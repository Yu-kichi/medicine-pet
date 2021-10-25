# frozen_string_literal: true

class MedicineNotebookController < ApplicationController
  # before_action :authenticate_user!
  def index
    if current_user
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
