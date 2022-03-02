# frozen_string_literal: true

class API::ClinicsController < API::BaseController
  before_action :authenticate_user!
  before_action :set_clinic, only: %i[edit update]

  def show
    @clinics = Clinic.where(prefecture_id: params[:id]).select(:id, :name)
  end

  def create
    @clinic = Clinic.new(clinic_params)
    if @clinic.save
      render json: { status: "Success", message: "Created the clinic", data: @clinic }
    else
      render json: { status: "Bad Request", message: @clinic.errors.full_messages }
    end
  end

  def edit; end

  def update
    if @clinic.update(clinic_params)
      render json: { status: "Success", message: "Updated the clinic", data: @clinic }
    else
      render json: { status: "Bad Request", message: @clinic.errors.full_messages }
    end
  end

  private
    def clinic_params
      params.require(:clinic).permit(:name, :address, :telephone_number, :prefecture_id, :user_id)
    end

    def set_clinic
      @clinic = Clinic.find(params[:id])
    end
end
