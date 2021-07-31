# frozen_string_literal: true

class Api::MedicinesController < ApplicationController
  before_action :authenticate_user!
  def index
    @medicines = Medicine.all.select(:id, :name)
  end
end
