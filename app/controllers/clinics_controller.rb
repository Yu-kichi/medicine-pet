# frozen_string_literal: true

class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[show edit update destroy]
  def index
    @clinics = Clinic.all
  end

  def show
  end

  def new
    @clinic = Clinic.new
    @pet = Pet.find_by(id: params[:pet_id])#これがないとformでエラー
  end

  def create
    #form_withではペットのidがparamsで通常送られてこない。
    #そのためペットidを抜き出してそれをparamsとしてhiddenで送らせる
    #もしくはcurrent_userのような仕組みでsesionn情報からidを取得する？
    @clinic = Clinic.new(clinic_params)
    if @clinic.save
      redirect_to @clinic, notice:  "Clinic was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:pet_id])
  end

  def update
    #@clinic = Clinic.new(clinic_params)
    if @clinic.update(clinic_params)
      redirect_to @clinic, notice: "Clinic was successfully updated."
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
      params.require(:clinic).permit(:name, :prescription_date, :doctor_name, :medical_fee, :medicine_fee, :memo, :pet_id)
    end
end
