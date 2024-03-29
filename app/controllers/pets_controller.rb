# frozen_string_literal: true

class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy]
  before_action :set_pets, only: %i[index show new edit update]
  before_action :authenticate_user!

  def index
    @pets = @pets.with_attached_image.order(:id)
  end

  def show; end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "ペットを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @pet.image.purge if params[:pet][:remove_image] == "1"
    if @pet.update(pet_params)
      redirect_to @pet, notice: "ペットを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_url, alert: "ペットを削除しました"
  end

  private
    def set_pet
      @pet = current_user.pets.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:name, :sex, :breed, :weight, :birthday, :user_id, :image)
    end
end
