# frozen_string_literal: true

module Api
  class MedicinesController < ApplicationController
    before_action :authenticate_user!
    def index
      @medicines = Medicine.all.select(:id, :name)
    end
  end
end
