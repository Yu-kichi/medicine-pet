# frozen_string_literal: true

class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[show edit update destroy]
  before_action :authenticate_user!
  def index
    @pets = current_user.pets
    @pet = Pet.find_by(id: params[:pet_id])
    @clinics = Clinic.all
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @pets = current_user.pets
    @clinic = Clinic.new
    session[:previous_url] = request.referer
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def create
    @clinic = Clinic.new(clinic_params)
    @session = session[:previous_url]
    if @clinic.save
      redirect_to @session, notice:  "Clinic was successfully created."
      session[:previous_url].clear
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    if @clinic.update(clinic_params)
      redirect_to pet_clinic_path(@clinic.pet_id, @clinic), notice: "Clinic was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @clinic.destroy
    redirect_to clinics_url, notice: "Clinic was successfully destroyed."
  end

  private
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    def clinic_params
      params.require(:clinic).permit(:name,:address,:telephone_number)
    end

    def set_request_from
      if session[:request_from]
        @request_from = session[:request_from]
      end
      # 現在のURLを保存しておく
      session[:request_from] = request.original_url
    end
end
