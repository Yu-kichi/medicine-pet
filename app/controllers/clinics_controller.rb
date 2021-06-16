# frozen_string_literal: true

class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[show edit update destroy]
  before_action :authenticate_user!
  def index
    @pets = Pet.all
    @pet = Pet.find_by(id: params[:pet_id])
    if @pet
      @clinics = @pet.clinics
    else
      @clinics = Clinic.all
    end
  end

  def show
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def new
    @clinic = Clinic.new
    @pet = Pet.find_by(id: params[:pet_id]) # これがないとformでエラー
  end

  def create
    # form_withではペットのidがparamsで通常送られてこない。
    # そのためペットidを抜き出してそれをparamsとしてhiddenで送らせる
    # もしくはcurrent_userのような仕組みでsesionn情報からidを取得する？
    @clinic = Clinic.new(clinic_params)
    if @clinic.save
      # ここで薬登録ページに進む
      redirect_to new_clinic_medicine_path(@clinic, @pet), notice:  "Clinic was successfully created."
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
    @pet = Pet.find_by(id: params[:pet_id])
    @clinic.destroy
    if @pet
      redirect_to pet_medicine_notebook_index_path(@pet), notice: "Clinic was successfully destroyed."
    else
      redirect_to clinics_url, notice: "Clinic was successfully destroyed."
    end
  end

  private
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    def clinic_params
      params.require(:clinic).permit(:name, :prescription_date, :doctor_name, :medical_fee, :medicine_fee, :memo, :pet_id)
    end
end
