# frozen_string_literal: true

class API::MedicinesController < API::BaseController
  before_action :authenticate_user!
  def index
    @medicines = Medicine.all.select(:id, :name)
  end
end
