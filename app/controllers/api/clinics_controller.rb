# frozen_string_literal: true

module Api
  class ClinicsController < ApplicationController
    before_action :authenticate_user!

    def index
      prefecture = Prefecture.find(params[:id])
      @clinics = prefecture.clinics.select(:id, :name)
    end
  end
end
