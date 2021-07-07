# frozen_string_literal: true

class PetsController < ApplicationController
  before_action :set_pet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
  end

  def show
    @pets = current_user.pets
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to @pet, notice:  "Pet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @pets = current_user.pets
    if @pet.update(pet_params)
      redirect_to @pet, notice: "Pet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_url, notice: "Pet was successfully destroyed."
  end

  private
    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:name, :sex, :breed, :weight, :birthday, :user_id, :image, :remove_image)
    end
end
