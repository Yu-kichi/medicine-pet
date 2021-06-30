# frozen_string_literal: true

class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[show edit update destroy]
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
    @pet = @pets.find_by(id: params[:pet_id])
    @medicines = Medicine.all
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @pets = current_user.pets
    @medicine = Medicine.new
    session[:previous_url] = request.referer
  end

  def create
    @medicine = Medicine.new(medicine_params)
    @session = session[:previous_url]
    if @medicine.save
      # redirect_to @medicine, notice:  "Medicine was successfully created."
      redirect_to @session, notice: "Medicine was successfully updated."
      session[:previous_url].clear
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    if @medicine.update(medicine_params)
      # redirect_to @medicine, notice: "Medicine was successfully updated."
      redirect_to pet_medicine_path(@medicine.pet_id, @medicine), notice: "Medicine was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find_by(id: params[:pet_id])
    @medicine.destroy
    if @pet
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "Medicine  was successfully destroyed."
    else
      redirect_to medicines_url, notice: "Medicine was successfully destroyed."
    end
  end

  private
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:name)
    end
end