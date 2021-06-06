class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[show edit destroy]
  def index
    @clinics = Clinic.all
  end

  def show
  end

  def new
    @clinic = Clinic.new
  end
  
  def create
    @clinic = Clinic.new(clinic_params)
    if @clinic.save
      redirect_to @clinic, notice:  "Clinic was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @clinic.update(clinic_params)
      redirect_to @clinic, notice: "Clinic was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def delete
    @clinic.destroy
    redirect_to clinics_url, notice: "Clinic was successfully destroyed."
  end

  private
  def set_clinic
    @clinic = Clinic.find(params[:id])
  end
  
  def clinic_params
    params.require(:clinic).permit(:name, :prescription_date, :doctor_name, :medical_fee, :medicine_fee, :memo)
  end
end
